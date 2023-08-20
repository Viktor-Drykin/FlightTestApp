//
//  Mocks.swift
//  FindFlightApp
//
//  Created by Viktor Drykin on 20.08.2023.
//

import Foundation


enum ErrorMock: Error {
    case mocked
}

class PlacesServiceMock: PlacesServiceProtocol {

    var originPlaces: [Node] = []
    var result: Result<[Node], Error> = .success([])

    func fetchPlaces(with text: String) async -> Result<[Node], Error> {
        return result
    }
}

class FlightsServiceMock: FlightsServiceProtocol {

    var result: Result<[Itinerary], Error> = .success([])

    func fetchFlights(startDate: String, endDate: String, sourceIds: [String], destinationIds: [String]) async -> Result<[Itinerary], Error> {
        return result
    }
}

class FlightsProviderMock: FlightsProviderProtocol {

    var result: Result<[FlightsModel], Error> = .success([])

    func fetchFlights(with date: Date, sourceIds: [String], destinationIds: [String]) async -> Result<[FlightsModel], Error> {
        return result
    }
}
