//
//  FlightsScreenBuilder.swift
//  FindFlight
//
//  Created by Viktor Drykin on 20.08.2023.
//

import SwiftUI

enum FlightsScreenBuilder {

    static func makeFlightsView(placesService: PlacesServiceProtocol,
                                flightsService: FlightsServiceProtocol) -> some View {
        let flightsPresenter = FlightsPresenter(placesService: placesService,
                                                flightsService: flightsService)
        let flightsObservable = FlightsObservable(flightsPresenter)
        flightsPresenter.scene = flightsObservable
        return FlightsView(observable: flightsObservable)
    }
}