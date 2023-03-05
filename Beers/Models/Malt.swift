//
//  Malt.swift
//  Beers
//
//  Created by DeStasio Pierluigi on 04/03/23.
//

import Foundation

public struct Malt: Codable {
    
    public var name: String?
    public var amount: ValueUnit?

    public init(name: String?, amount: ValueUnit?) {
        self.name = name
        self.amount = amount
    }

}

