//
//  BeerMethod.swift
//  Beers
//
//  Created by DeStasio Pierluigi on 04/03/23.
//

import Foundation

struct BeerMethod: Codable {
    public var mashTemp: [MashTemp]?
    public var fermentation: Fermentation?
    public var twist: String?

    public init(mashTemp: [MashTemp]?, fermentation: Fermentation?, twist: String?) {
        self.mashTemp = mashTemp
        self.fermentation = fermentation
        self.twist = twist
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case mashTemp = "mash_temp"
        case fermentation
        case twist
    }
}
