//
//  FlightsObservable.swift
//  FindFlight
//
//  Created by Viktor Drykin on 19.08.2023.
//

import Foundation

class FlightsObservable: ObservableObject {
    
    @Published var viewModel: Flights.ViewModel
    
    private let presenter: FlightsPresenting
    
    init(_ presenter: FlightsPresenting) {
        self.presenter = presenter
        viewModel = presenter.viewModel
    }
}

extension FlightsObservable: FlightsScene {

    @MainActor
    func perform(update: Flights.Update) {
        switch update {
        case .viewModel:
            self.viewModel = self.presenter.viewModel
        }
    }

    func perform(action: Flights.Action) {
        switch action {
        case .searchFlights(let date):
            Task {
                await presenter.searchFlights(for: date)
            }
        }
    }
}



