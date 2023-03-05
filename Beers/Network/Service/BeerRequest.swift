//
//  BeerRequest.swift
//  Beers
//
//  Created by DeStasio Pierluigi on 04/03/23.
//

import Foundation

struct BeerRequest {
    var path: String {
        return "beers"
    }

    let parameters: Parameters
    init(parameters: Parameters) {
        self.parameters = parameters
    }
}
