//
//  FindFlightAppApp.swift
//  FindFlightApp
//
//  Created by Viktor Drykin on 20.08.2023.
//

import SwiftUI

@main
struct FindFlightAppApp: App {
    var body: some Scene {
        WindowGroup {
            t()
            ContentView()
        }
    }
}

func t() -> some View {
    let graphqlURL = URL(string: "https://api.skypicker.com/umbrella/v2/graphql")!

    Task {
        let flights = await FlightsService(apiService: APIService(), url: graphqlURL).fetchFlights(with: Date.now, sourceIds: ["City:brno_cz"], destinationIds: ["City:new-york-city_ny_us"])
    }
    return Text("234")
}
