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

    func fetchFlights(with date: Date, sourceIds: [String], destinationIds: [String]) async -> Result<[Itinerary], Error> {

        let startDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
        let endDate = Calendar.current.date(bySettingHour: 23, minute: 59, second: 0, of: date)!

        let startString = dateFormatter.string(from: startDate)
        let endString = dateFormatter.string(from: endDate)
        
        let operation = GraphQLOperation<FlightsInput, OnewayItineraries>(
            url: url,
            input: .init(startDate: startString,
                         endDate: endString,
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
