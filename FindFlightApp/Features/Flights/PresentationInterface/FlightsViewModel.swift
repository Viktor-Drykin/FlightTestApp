//
//  FlightsViewModel.swift
//  FindFlight
//
//  Created by Viktor Drykin on 19.08.2023.
//

import Foundation

enum Flights {

    struct ViewModel: Hashable {

        struct Flight: Hashable, Identifiable {
            let id = UUID()
            let imageURL: URL?
            let origin: String
            let destination: String
            let date: Date?
            let price: String?
        }

        enum FlightsState: Hashable {

            enum ErrorType: Hashable {
                case uknown
                case server
                case decoding
            }
            case initial
            case loaded([Flight])
            case empty
            case error(ErrorType)
        }

        let originsPlaceTitles: String
        let isSearching: Bool
        let selectedDate: Date
        let flightsState: FlightsState
    }

    enum Update {
        case viewModel
    }

    enum Action {
        case searchFlights(date: Date)
    }
}
