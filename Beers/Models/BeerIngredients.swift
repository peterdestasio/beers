//
//  BeerIngredients.swift
//  Beers
//
//  Created by DeStasio Pierluigi on 04/03/23.
//

import Foundation

struct BeerIngredients: Codable {    
    public var malt: [Malt]?
    public var hops: [Hope]?
    public var yeast: String?

    public init(malt: [Malt]?, hops: [Hope]?, yeast: String?) {
        self.malt = malt
        self.hops = hops
        self.yeast = yeast
    }
}
