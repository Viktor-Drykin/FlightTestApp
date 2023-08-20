//
//  FlightsMapper.swift
//  FindFlight
//
//  Created by Viktor Drykin on 20.08.2023.
//

import Foundation

struct FlightsMapper {

    static func map(model: FlightsModel) -> Flights.ViewModel.Flight {
        let url = URL(string: "https://images.kiwi.com/photos/600x600/\(model.destination.legacyId).jpg")
        return .init(imageURL: url,
                     origin: model.source.name,
                     destination: model.destination.name,
                     date: model.date,
                     price: model.price)
    }
}
