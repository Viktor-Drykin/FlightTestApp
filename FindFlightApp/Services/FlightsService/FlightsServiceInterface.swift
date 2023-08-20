//
//  FlightsServiceInterface.swift
//  FindFlightApp
//
//  Created by Viktor Drykin on 20.08.2023.
//

import Foundation

protocol FlightsServiceProtocol: AnyObject {
    func fetchFlights(with date: Date, sourceIds: [String], destinationIds: [String]) async -> Result<[Itinerary], Error>
}
