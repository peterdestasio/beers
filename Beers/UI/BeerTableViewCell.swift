//
//  BeerTableViewCell.swift
//  Beers
//
//  Created by DeStasio Pierluigi on 04/03/23.
//

import UIKit

protocol BeerViewCellProtocol {
    func showBeerDetailSheet(beer: Beer)
}

final class BeerTableViewCell: UITableViewCell {
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerTaglineLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    @IBOutlet weak var beerImageView: UIImageView!
    var beer: Beer!
    var delegate: BeerViewCellProtocol!
    func configure(with beer: Beer?) {
        if let beer = beer {
            beerNameLabel.text = beer.name
            beerTaglineLabel.text = beer.tagline
            beerDescriptionLabel.text = beer.description
            self.beer = beer
        } else {
            beerNameLabel.text = ""
            beerTaglineLabel.text = ""
            beerDescriptionLabel.text = ""
            beerImageView.image = nil
        }
    }
    
    override func prepareForReuse() {
      super.prepareForReuse()
      configure(with: .none)
    }
    @IBAction func moreInfoButtonPressed(_ sender: Any) {
        self.delegate.showBeerDetailSheet(beer: beer)
    }
}
