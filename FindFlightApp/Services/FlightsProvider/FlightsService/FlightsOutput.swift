//
//  FlightsOutput.swift
//  FindFlight
//
//  Created by Viktor Drykin on 19.08.2023.
//

import Foundation

// MARK: - OnewayItineraries
struct OnewayItineraries: Decodable {
    let itineraries: [Itinerary]
}

// MARK: - Itinerary
struct Itinerary: Decodable {
    let id: String
    let duration: Int
    let cabinClasses: [CabinClass]
    let priceEur: PriceEur
    let bookingOptions: BookingOptions
    let provider: Provider
    let sector: Sector
}

// MARK: - BookingOptions
struct BookingOptions: Decodable {
    let edges: [BookingOptionsEdge]
}

// MARK: - Edge
struct BookingOptionsEdge: Decodable {
    let node: EdgeNode
}

// MARK: - Node
struct EdgeNode: Decodable {
    let bookingURL: String
    let price: Price

    enum CodingKeys: String, CodingKey {
        case bookingURL = "bookingUrl"
        case price
    }
}

// MARK: - Price
struct Price: Decodable {
    let amount, formattedValue: String
}

enum CabinClass: String, Decodable {
    case economy = "ECONOMY"
}

// MARK: - PriceEur
struct PriceEur: Decodable {
    let amount: String
}

// MARK: - Provider
struct Provider: Decodable {
    let id, name, code: String
}

// MARK: - Sector
struct Sector: Decodable {
    let id: String
    let duration: Int
    let sectorSegments: [SectorSegment]
}

// MARK: - SectorSegment
struct SectorSegment: Decodable {
    let segment: Segment
    let layover: Layover?
    let guarantee: Guarantee?
}

enum Guarantee: String, Decodable {
    case kiwiCOM = "KIWI_COM"
}

// MARK: - Layover
struct Layover: Decodable {
    let duration: Int
    let isBaggageRecheck: Bool
    let transferDuration: Int?
    let transferType: String?
}

// MARK: - Segment
struct Segment: Decodable {
    let id: String
    let duration: Int
    let type: SegmentType
    let code: String
    let source, destination: Destination
    let carrier: Provider
    let operatingCarrier: Provider?
}

// MARK: - Destination
struct Destination: Decodable {
    let utcTime, localTime: String
    let station: Station
}

// MARK: - Station
struct Station: Decodable {
    let id, name, code: String
    let type: StationType
    let city: City
}

// MARK: - City
struct City: Decodable {
    let id, legacyID, name: String
    let country: Country

    enum CodingKeys: String, CodingKey {
        case id
        case legacyID = "legacyId"
        case name, country
    }
}

// MARK: - Country
struct Country: Decodable {
    let id, name: String
}

enum StationType: String, Decodable {
    case airport = "AIRPORT"
}

enum SegmentType: String, Decodable {
    case flight = "FLIGHT"
}
