//
//  FlightsProvider.swift
//  FindFlightApp
//
//  Created by Viktor Drykin on 20.08.2023.
//

import Foundation

protocol FlightsProviderProtocol: AnyObject {
    func fetchFlights(with date: Date, sourceIds: [String], destinationIds: [String]) async -> Result<[FlightsModel], Error>
}

class FlightsProvider {

    let flightsService: FlightsServiceProtocol
    let flightsStorage: FlightResultsStorageProtocol

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter
    }()

    init(flightsService: FlightsServiceProtocol, flightsStorage: FlightResultsStorageProtocol) {
        self.flightsService = flightsService
        self.flightsStorage = flightsStorage
    }
}

extension FlightsProvider: FlightsProviderProtocol {

    func fetchFlights(with date: Date, sourceIds: [String], destinationIds: [String]) async -> Result<[FlightsModel], Error> {

        let startDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
        let endDate = Calendar.current.date(bySettingHour: 23, minute: 59, second: 0, of: date)!

        let startString = dateFormatter.string(from: startDate)
        let endString = dateFormatter.string(from: endDate)

        let flightsResult = await flightsService.fetchFlights(startDate: startString,
                                                              endDate: endString,
                                                              sourceIds: sourceIds,
                                                              destinationIds: destinationIds)
        return flightsResult.map { itineraties in
            let models = itineraties
                .map { FlightsModelMapper.map(itinerary: $0, dateFormatter: dateFormatter) }
                .compactMap { $0 }

            var filteredModels: [FlightsModel] = []
            for model in models {
                if flightsStorage.canShow(flight: model, date: date) {
                    if filteredModels.count < 5 {
                        filteredModels.append(model)
                        flightsStorage.storeFlight(flight: model, date: date)
                    } else {
                        return filteredModels
                    }
                }
            }
            return filteredModels
        }
    }
}
