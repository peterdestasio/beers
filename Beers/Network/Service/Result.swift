//
//  Result.swift
//  Beers
//
//  Created by DeStasio Pierluigi on 04/03/23.
//

import Foundation

enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}
