//
//  FlightResultsStorage.swift
//  FindFlightApp
//
//  Created by Viktor Drykin on 20.08.2023.
//

import Foundation

protocol FlightResultsStorageProtocol: AnyObject {
    func canShow(flight: FlightsModel, date: Date) -> Bool
    func storeFlight(flight: FlightsModel, date: Date)
}

class FlightResultsStorage {

    var storedFlights: [Date: Set<FlightStoredModel>] = [:]

    init() {}
}

extension FlightResultsStorage: FlightResultsStorageProtocol {

    func canShow(flight: FlightsModel, date: Date) -> Bool {
        let date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
        let storedFlightsOnDate = storedFlights[date] ?? .init()
        let storedModel: FlightStoredModel = .init(with: flight)
        return !storedFlights.values
            .reduce(Set<FlightStoredModel>(), { $0.union($1) })
            .subtracting(storedFlightsOnDate)
            .contains(storedModel)
    }

    func storeFlight(flight: FlightsModel, date: Date) {
        let date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
        var storedFlightsOnDate = storedFlights[date] ?? .init()
        let storedModel: FlightStoredModel = .init(with: flight)
        storedFlightsOnDate.insert(storedModel)
        storedFlights[date] = storedFlightsOnDate
    }
}
