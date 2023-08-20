//
//  FlightsMapper.swift
//  FindFlight
//
//  Created by Viktor Drykin on 20.08.2023.
//

import Foundation

struct FlightsMapper {

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter
    }()

    static func map(itinerary: Itinerary) -> Flights.ViewModel.Flight? {
        let source = itinerary.sector.sectorSegments.first?.segment.source
        let destinationStation = itinerary.sector.sectorSegments.last?.segment.destination.station

        guard
            let source = source,
            let destinationStation = destinationStation
        else {
            return nil
        }

        let destinationCityId = destinationStation.city.legacyID
        let url = URL(string: "https://images.kiwi.com/photos/600x600/\(destinationCityId).jpg")
        let origin = source.station.city.name
        let destination = destinationStation.name
        let price = itinerary.bookingOptions.edges.first?.node.price.formattedValue
        let startDate = dateFormatter.date(from: source.utcTime)
       return .init(imageURL: url, origin: origin, destination: destination, date: startDate, price: price)
    }
}
