//
//  FlightsPresenter.swift
//  FindFlight
//
//  Created by Viktor Drykin on 19.08.2023.
//

import Foundation

class FlightsPresenter {

    var viewModel: Flights.ViewModel
    weak var scene: FlightsScene?
    unowned let placesService: PlacesServiceProtocol
    unowned let flightsProvider: FlightsProviderProtocol

    init(
        placesService: PlacesServiceProtocol,
        flightsProvider: FlightsProviderProtocol
    ) {
        self.placesService = placesService
        self.flightsProvider = flightsProvider
        let sourceNames = placesService.originPlaces
            .map { $0.name }
            .joined(separator: ", ")
        viewModel = .init(originsPlaceTitles: sourceNames,
                          isSearching: false,
                          selectedDate: Date.now,
                          flightsState: .initial)
    }
}

extension FlightsPresenter: FlightsPresenting {

    func searchFlights(for date: Date) async {
        let sourceIds = placesService.originPlaces
            .map { $0.id }
        viewModel = .init(originsPlaceTitles: viewModel.originsPlaceTitles,
                          isSearching: true,
                          selectedDate: date,
                          flightsState: .initial)
        self.scene?.perform(update: .viewModel)
        let topPlacesResult = await placesService.fetchPlaces(with: "")
        switch topPlacesResult {
        case .success(let nodes):
            let flightsResult = await flightsProvider.fetchFlights(with: date,
                                                                  sourceIds: sourceIds,
                                                                  destinationIds: nodes.map { $0.id })
            switch flightsResult {
            case .success(let flightModels):
                let flightsViewModels = flightModels.map { FlightsMapper.map(model: $0) }
                let flightsState: Flights.ViewModel.FlightsState = flightsViewModels.isEmpty ? .empty : .loaded(flightsViewModels)
                viewModel = .init(originsPlaceTitles: viewModel.originsPlaceTitles,
                                  isSearching: false,
                                  selectedDate: viewModel.selectedDate,
                                  flightsState: flightsState)
            case .failure(let error):
                viewModel = viewModel(with: error)
            }
        case .failure(let error):
            viewModel = viewModel(with: error)
        }
        self.scene?.perform(update: .viewModel)
    }

    func viewModel(with error: Error) -> Flights.ViewModel {

        let flightsViewModel: Flights.ViewModel

        guard let error = error as? NetworkError else {
            flightsViewModel = .init(originsPlaceTitles: viewModel.originsPlaceTitles, isSearching: false, selectedDate: viewModel.selectedDate, flightsState: .error(.uknown))
            return flightsViewModel
        }
        switch error {
        case .failedToDecode:
            flightsViewModel = .init(originsPlaceTitles: viewModel.originsPlaceTitles, isSearching: false, selectedDate: viewModel.selectedDate, flightsState: .error(.decoding))
        case .invalidStatusCode:
            flightsViewModel = .init(originsPlaceTitles: viewModel.originsPlaceTitles, isSearching: false, selectedDate: viewModel.selectedDate, flightsState: .error(.server))
        case .unknown:
            flightsViewModel = .init(originsPlaceTitles: viewModel.originsPlaceTitles, isSearching: false, selectedDate: viewModel.selectedDate, flightsState: .error(.uknown))
        }

        return flightsViewModel
    }
}
