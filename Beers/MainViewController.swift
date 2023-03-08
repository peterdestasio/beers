//
//  ViewController.swift
//  Beers
//
//  Created by DeStasio Pierluigi on 04/03/23.
//

import UIKit

final class MainViewController: UIViewController, AlertDisplayer {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var scrollView: UIScrollView!
    private var viewModel: BeerViewModel!
    private var imageDownloader = ImageDownloaderService()
    private var lastPressedButtonTag = 0
    private var isFirstSelection = true
    private let svButtons = ScrollViewButtons.shared
    
    private lazy var detailVC: BeerDetailViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "BeerDetailViewController") as! BeerDetailViewController
        navigationController?.addChild(viewController)
            return viewController
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        styleNavBar()
        addFilterButtons()
        setTableView()
        
        let request = BeerRequest(parameters: ["page": "1"])
        viewModel = BeerViewModel(request: request, delegate: self)
        viewModel.fetchBeers()        
    }
    
    func deselectAllButtons() {
        isFirstSelection = true
        for button in scrollView.subviews {
            button.backgroundColor = .darkText
            button.tintColor = .gray
        }
    }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 160
        tableView.keyboardDismissMode = .onDrag
    }
    
    func addFilterButtons() {
        var frame : CGRect?
        let padding = 5
        var lastX = 10
  
        for i in 0..<svButtons.buttonNames.count {
            let button = UIButton(type: .roundedRect)
            let width = (svButtons.buttonNames[i].count * 10) + 10
            frame = CGRect(x: lastX, y: 10, width: width, height: 30)
                lastX += (width + padding)
            button.frame = frame!
            button.tag = i
            button.backgroundColor = .darkText
            button.tintColor = .gray
            button.layer.cornerRadius = 15
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.addTarget(self, action: #selector(filterButton), for: .touchUpInside)
            button.setTitle(svButtons.buttonNames[i], for: .normal)
            scrollView.addSubview(button)
        }
        scrollView.contentSize = CGSize( width: CGFloat(lastX) + 20, height: scrollView.frame.size.height)

    }
    @objc func filterButton(sender: UIButton) {
        if isFirstSelection {
            filterBeers(sender: sender)
            isFirstSelection = false
        } else if lastPressedButtonTag == sender.tag  {
            viewModel.cancelSearch()
            sender.backgroundColor = .darkText
            sender.tintColor = .gray
            lastPressedButtonTag = 0
            isFirstSelection = true
        } else {
            filterBeers(sender: sender)
        }
        searchBar.text = ""

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func filterBeers(sender: UIButton) {
        viewModel.fetchBeers()
        viewModel.filterBeers(by: svButtons.buttonStrings[sender.tag])
        deselectAllButtons()
        sender.tintColor = .black
        sender.backgroundColor = UIColor(named: "BeerAccent")
        lastPressedButtonTag = sender.tag
    }
    
    func styleNavBar() {
        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "Beer", attributes:[
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.light)])
        navTitle.append(NSMutableAttributedString(string: " Box", attributes:[
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17.0),
            NSAttributedString.Key.foregroundColor: UIColor.white]))
        navLabel.attributedText = navTitle
        self.navigationItem.titleView = navLabel
    }

}

extension MainViewController: BeerViewModelDelegate {
    func onFetchCompleted(with newIndexPathToReload: [IndexPath]?) {
        guard let newIndexPathToReload = newIndexPathToReload else {
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
            return
        }
        let indexPathToReload = visibleIndexPathsToReload(intersecting: newIndexPathToReload)
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.reloadRows(at: indexPathToReload, with: .automatic)
        }
    }
    
    func onFetchFailed(with reason: String) {
        let title = "Error"
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: title , message: reason, actions: [action])
    }
}

extension MainViewController: BeerViewCellProtocol {
    func showBeerDetailSheet(beer: Beer) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "BeerDetailViewController") as! BeerDetailViewController
        detailVC.beer = beer
        detailVC.modalPresentationStyle = .overCurrentContext
        navigationController?.present(detailVC, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeerCell", for: indexPath) as! BeerTableViewCell
        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none)
        } else {
            if let imageURL = viewModel.beer(at: indexPath.row).imageUrl {
                imageDownloader.getImage(imagePath: imageURL) { image in
                    cell.beerImageView.image = image
                }
            }
            cell.configure(with: viewModel.beer(at: indexPath.row))
        }
        cell.delegate = self
        return cell
    }
}

extension MainViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

       if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchBeers()
         }
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        deselectAllButtons()
        searchText.isEmpty ? viewModel.cancelSearch() : viewModel.filterBeers(by: searchText)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

private extension MainViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        if viewModel.isInSearchMode {
            viewModel.fetchBeers()
            return false
        } else {
            return indexPath.row >= viewModel.currentCount - 5
        }
     }

     func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
       let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
       let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
       return Array(indexPathsIntersection)
     }
}

