//
//  FlightsModelMapper.swift
//  FindFlightApp
//
//  Created by Viktor Drykin on 20.08.2023.
//

import Foundation

enum FlightsModelMapper {

    static func map(itinerary: Itinerary, dateFormatter: DateFormatter) -> FlightsModel? {
        let source = itinerary.sector.sectorSegments.first?.segment.source
        let destination = itinerary.sector.sectorSegments.last?.segment.destination

        guard
            let source = source,
            let destination = destination,
            let price = itinerary.bookingOptions.edges.first?.node.price.formattedValue,
            let startDate = dateFormatter.date(from: source.utcTime)
        else {
            return nil
        }

        return .init(source: .init(code:  source.station.code,
                                   name:  source.station.city.name,
                                   legacyId: source.station.city.legacyID,
                                   id: ""),
                     destination: .init(code: destination.station.code,
                                            name: destination.station.name,
                                            legacyId: destination.station.city.legacyID,
                                            id: ""),
                     date: startDate,
                     price: price)
    }

}
