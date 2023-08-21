//
//  FlightListView.swift
//  FindFlight
//
//  Created by Viktor Drykin on 20.08.2023.
//

import SwiftUI

struct FlightListView: View {

    let flightsState: Flights.ViewModel.FlightsState

    var body: some View {
        switch flightsState {
        case .initial:
            EmptyView()
        case .empty:
            Text(Constant.empty)
        case .loaded(let flights):
            GeometryReader { geo in
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(flights, id: \.self) { flight in
                            let itemWidth = geo.size.width * 0.8
                            FlightItemView(flight: flight, imageWidth: itemWidth)
                                .frame(width: itemWidth, height: geo.size.height)
                        }
                    }
                }
            }
        case .error(let type):
            switch type {
            case .decoding:
                Text(Constant.decodingError)
            case .server:
                Text(Constant.serverError)
            case .unknown:
                Text(Constant.unknownError)
            }
        }
    }
}

extension FlightListView {
    enum Constant {
        static let empty = "No results"
        static let decodingError = "Incorrect response from server"
        static let serverError = "Invalid status response"
        static let unknownError = "Something went wrong"
    }
}

