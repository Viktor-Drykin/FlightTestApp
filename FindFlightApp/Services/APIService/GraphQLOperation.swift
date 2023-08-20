//
//  GraphQLOperation.swift
//  FlightTestApp
//
//  Created by Viktor Drykin on 17.08.2023.
//

import Foundation

struct GraphQLOperation<Input: Encodable, Output: Decodable>: Encodable {

    let url: URL
    let input: Input
    let operationString: String

    init(url: URL, input: Input, operationString: String) {
        self.url = url
        self.input = input
        self.operationString = operationString
    }

    enum CodingKeys: String, CodingKey {
        case variables
        case query
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(input, forKey: .variables)
        try container.encode(operationString, forKey: .query)
    }

    func getURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(self)

        return request
    }
}
