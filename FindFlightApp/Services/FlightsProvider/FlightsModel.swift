//
//  FlightsModel.swift
//  FindFlightApp
//
//  Created by Viktor Drykin on 20.08.2023.
//

import Foundation

struct FlightsModel: Hashable {
    struct Place: Hashable {
        let code: String
        let name: String
        let legacyId: String
        let id: String
    }

    let source: Place
    let destination: Place
    let date: Date
    let price: String
}
