//
//  DataResponseError.swift
//  Beers
//
//  Created by DeStasio Pierluigi on 04/03/23.
//

import Foundation

enum DataResponseError: Error {
    case network
    case decoding
    
    var reason: String {
        switch self {
        case .network:
            return "Network error"
        case .decoding:
            return "Error decoding the data"
        }
    }
}
