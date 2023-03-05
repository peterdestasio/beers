//
//  Hope.swift
//  Beers
//
//  Created by DeStasio Pierluigi on 04/03/23.
//

import Foundation

public struct Hope: Codable {
    public var name: String?
    public var amount: ValueUnit?
    public var add: String?
    public var attribute: String?

    public init(name: String?, amount: ValueUnit?, add: String?, attribute: String?) {
        self.name = name
        self.amount = amount
        self.add = add
        self.attribute = attribute
    }
}
