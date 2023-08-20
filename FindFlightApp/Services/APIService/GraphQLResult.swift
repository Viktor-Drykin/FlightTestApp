//
//  GraphQLResult.swift
//  FlightTestApp
//
//  Created by Viktor Drykin on 17.08.2023.
//

import Foundation

struct GraphQLResult<T: Decodable>: Decodable {
    let object: T?
    let errorMessages: [String]

    enum CodingKeys: String, CodingKey {
        case data
        case errors
    }

    struct Error: Decodable {
        let message: String
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let dataDict = try container.decodeIfPresent([String: T].self, forKey: .data)
        self.object = dataDict?.values.first

        var errorMessages: [String] = []

        let errors = try container.decodeIfPresent([Error].self, forKey: .errors)
        if let errors = errors {
            errorMessages.append(contentsOf: errors.map { $0.message })
        }

        self.errorMessages = errorMessages
    }
}
