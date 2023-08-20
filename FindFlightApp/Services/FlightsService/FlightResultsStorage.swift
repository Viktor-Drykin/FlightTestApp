//
//  FlightResultsStorage.swift
//  FindFlightApp
//
//  Created by Viktor Drykin on 20.08.2023.
//

import Foundation

struct StoredFlightItem: Hashable {
    let source: String
    let destination: String
}

protocol FlightResultsStorageProtocol: AnyObject {
    func canShow(flight: StoredFlightItem, date: Date) -> Bool
    func storeFlight(flight: StoredFlightItem, date: Date)
}

class FlightResultsStorage {

    var storedFlights: [Date: Set<StoredFlightItem>] = [:]

    init() { }
}

extension FlightResultsStorage: FlightResultsStorageProtocol {

    func canShow(flight: StoredFlightItem, date: Date) -> Bool {
        let date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
        let storedFlightsOnDate = storedFlights[date] ?? .init()
        return !storedFlights.values
            .reduce(Set<StoredFlightItem>(), { $0.union($1) })
            .subtracting(storedFlightsOnDate)
            .contains(flight)
    }

    func storeFlight(flight: StoredFlightItem, date: Date) {
        let date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
        var storedFlightsOnDate = storedFlights[date] ?? .init()
        storedFlightsOnDate.insert(flight)
        storedFlights[date] = storedFlightsOnDate
    }
}
