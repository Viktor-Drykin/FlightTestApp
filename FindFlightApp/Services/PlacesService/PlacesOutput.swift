//
//  PlacesDTO.swift
//  FlightTestApp
//
//  Created by Viktor Drykin on 17.08.2023.
//

import Foundation

// MARK: - PlacesClass
struct Places: Decodable {
    let edges: [Edge]
}


// MARK: - Edge
struct Edge: Decodable {
    let node: Node
}

// MARK: - Node
struct Node: Decodable {
    let id: String
    let legacyID: String
    let name: String
    let gps: GPS

    enum CodingKeys: String, CodingKey {
        case id
        case legacyID = "legacyId"
        case name
        case gps
    }
}

// MARK: - Gps
struct GPS: Decodable {
    let lat: Double
    let lng: Double
}
