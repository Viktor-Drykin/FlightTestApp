//
//  Launcher.swift
//  FindFlight
//
//  Created by Viktor Drykin on 18.08.2023.
//

import Foundation
import SwiftUI

class Launcher {

    let apiService: APIServicePerformable
    let placesService: PlacesServiceProtocol
    let flightsProviver: FlightsProviderProtocol

    init() {
        apiService = APIService()
        let graphqlURL = URL(string: "https://api.skypicker.com/umbrella/v2/graphql")!
        placesService = PlacesService(apiService: apiService, url: graphqlURL)
        let flightsService = FlightsService(apiService: apiService,
                                            url: graphqlURL)
        let flightsStorage = FlightResultsStorage()
        flightsProviver = FlightsProvider(flightsService: flightsService,
                                          flightsStorage: flightsStorage)
    }

    var launchScreen: some View {
        FlightsScreenBuilder.makeFlightsView(placesService: placesService,
                                             flightsProvider: flightsProviver)
    }
}
