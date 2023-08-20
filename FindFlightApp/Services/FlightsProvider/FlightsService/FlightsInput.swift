//
//  FlightsInput.swift
//  FindFlight
//
//  Created by Viktor Drykin on 19.08.2023.
//

import Foundation

struct FlightsInput: Encodable {
    let startDate: String
    let endDate: String
    let sourceIds: [String]
    let destinationIds: [String]
}
