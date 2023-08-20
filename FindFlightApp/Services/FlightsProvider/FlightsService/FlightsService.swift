//
//  FlightsService.swift
//  FindFlight
//
//  Created by Viktor Drykin on 19.08.2023.
//

import Foundation

class FlightsService {

    let apiService: APIServicePerformable
    let url: URL

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter
    }()

    init(apiService: APIServicePerformable, url: URL) {
        self.apiService = apiService
        self.url = url
    }
}

extension FlightsService: FlightsServiceProtocol {

    func fetchFlights(startDate: String, endDate: String, sourceIds: [String], destinationIds: [String]) async -> Result<[Itinerary], Error> {
        
        let operation = GraphQLOperation<FlightsInput, OnewayItineraries>(
            url: url,
            input: .init(startDate: startDate,
                         endDate: endDate,
                         sourceIds: sourceIds,
                         destinationIds: destinationIds),
            operationString: flightsQueryBody
        )

        do {
            let itinerary = try await apiService.perform(operation)
            return itinerary.map { $0.itineraries }
        } catch {
            return .failure(error)
        }
    }

}
