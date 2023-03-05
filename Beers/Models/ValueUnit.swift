//
//  ValueUnit.swift
//  Beers
//
//  Created by DeStasio Pierluigi on 04/03/23.
//

import Foundation

public struct ValueUnit: Codable {
    var value: Float?
    var unit: String?

    public init(value: Float?, unit: String?) {
        self.value = value
        self.unit = unit
    }

}
