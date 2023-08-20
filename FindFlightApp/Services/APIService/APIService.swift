//
//  APIService.swift
//  FlightTestApp
//
//  Created by Viktor Drykin on 17.08.2023.
//

import Foundation

protocol APIServicePerformable {
    func perform<Input, Output>(_ operation: GraphQLOperation<Input, Output>) async throws -> Result<Output, Error>
}

class APIService: APIServicePerformable {

    func perform<Input, Output>(_ operation: GraphQLOperation<Input, Output>) async throws -> Result<Output, Error> {

        let request: URLRequest = try operation.getURLRequest()
        let (data, response) = try await URLSession.shared.data(for: request)

        guard
            let response = response as? HTTPURLResponse,
            (200...299).contains(response.statusCode)
        else {
            throw NetworkError.invalidStatusCode
        }

        let result = try JSONDecoder().decode(GraphQLResult<Output>.self, from: data)
        if let object = result.object {
            return .success(object)
        } else {
            return .failure(NetworkError.failedToDecode)
        }
    }
}
