//
//  APIServiceInterface.swift
//  FindFlightApp
//
//  Created by Viktor Drykin on 20.08.2023.
//

import Foundation

protocol APIServicePerformable {
    func perform<Input, Output>(_ operation: GraphQLOperation<Input, Output>) async throws -> Result<Output, Error>
}
