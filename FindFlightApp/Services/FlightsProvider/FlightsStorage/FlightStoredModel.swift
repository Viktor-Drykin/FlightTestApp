//
//  FlightStoredModel.swift
//  FindFlightApp
//
//  Created by Viktor Drykin on 20.08.2023.
//

import Foundation

struct FlightStoredModel: Hashable {
    let sourceCode: String
    let destinationCode: String
}

extension FlightStoredModel {
    init(with model: FlightsModel) {
        self.sourceCode = model.source.code
        self.destinationCode = model.destination.code
    }
}
