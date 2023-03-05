//
//  MashTemp.swift
//  Beers
//
//  Created by DeStasio Pierluigi on 04/03/23.
//

import Foundation

public struct MashTemp: Codable {
    public var temp: ValueUnit?
    public var duartion: Double?

    public init(temp: ValueUnit?, duartion: Double?) {
        self.temp = temp
        self.duartion = duartion
    }
}
