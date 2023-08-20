//
//  FlightsServiceInterface.swift
//  FindFlightApp
//
//  Created by Viktor Drykin on 20.08.2023.
//

import Foundation

protocol FlightsServiceProtocol: AnyObject {
    func fetchFlights(startDate: String, endDate: String, sourceIds: [String], destinationIds: [String]) async -> Result<[Itinerary], Error>
}
