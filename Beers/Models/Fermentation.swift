//
//  Fermentation.swift
//  Beers
//
//  Created by DeStasio Pierluigi on 04/03/23.
//

import Foundation

public struct Fermentation: Codable {

    public var temp: ValueUnit?
    public init(temp: ValueUnit?) {
        self.temp = temp
    }

}
