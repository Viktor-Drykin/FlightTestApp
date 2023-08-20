//
//  NetworkError.swift
//  FindFlight
//
//  Created by Viktor Drykin on 20.08.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidStatusCode
    case failedToDecode
    case unknown
}
