//
//  BeerDetailViewController.swift
//  Beers
//
//  Created by DeStasio Pierluigi on 04/03/23.
//

import UIKit

final class BeerDetailViewController: UIViewController {
    @IBOutlet weak var bottomSheet: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var beerTitleLabel: UILabel!
    @IBOutlet weak var beerTaglineLabel: UILabel!
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    
    var bottomSheetArea: CGRect?
    var beer: Beer!
    private var imageDownloader = ImageDownloaderService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomSheetArea = bottomSheet.bounds
        beerTitleLabel.text = beer.name
        beerTaglineLabel.text = beer.tagline
        beerDescriptionLabel.text = beer.description
        if let imageUrl = beer.imageUrl {
            imageDownloader.getImage(imagePath: imageUrl, completionHandler: { image in
                self.beerImageView.image = image
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animateBackgroundView(isAppearing: true)
    }
    
    func animateBackgroundView(isAppearing : Bool) {
        UIView.transition(with: backgroundView, duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: { isAppearing ? (self.backgroundView.alpha = 0.5) : (self.backgroundView.alpha = 1)}
        ) { finished in
            self.backgroundView.backgroundColor = .black
            if !isAppearing {
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func didTapView(_ sender: UITapGestureRecognizer) {
        let locationTapped = sender.location(in: self.view)
        if !bottomSheet.frame.contains(locationTapped) {
            animateBackgroundView(isAppearing: false)
        }
    }
}
