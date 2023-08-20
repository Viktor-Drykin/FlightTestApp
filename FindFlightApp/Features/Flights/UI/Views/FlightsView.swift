//
//  FlightsView.swift
//  FindFlight
//
//  Created by Viktor Drykin on 19.08.2023.
//

import SwiftUI

struct FlightsView: View {

    @ObservedObject var observable: FlightsObservable

    @State private var selectedDate = Date.now

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    public init(observable: FlightsObservable) {
        self.observable = observable
    }

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
                VStack(alignment: .leading) {
                    HStack {
                        Text(Constant.fromTitle)
                            .fontWeight(.bold)
                            .font(.title3)
                        +
                        Text(observable.viewModel.originsPlaceTitles)
                            .font(.title3)
                        Spacer()
                    }
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text(Constant.toTitle)
                            .fontWeight(.bold)
                            .font(.title3)
                        +
                        Text(Constant.toDestinationName)
                            .font(.title3)
                        Spacer()
                    }
            }
            DatePicker(Constant.selectedDateTitle,
                       selection: $selectedDate,
                       displayedComponents: .date)
                .datePickerStyle(.compact)
            Button {
                observable.perform(action: .searchFlights(date: selectedDate))
            } label: {
                Text(Constant.searchButtonTitle)
                    .padding(8)
                if observable.viewModel.isSearching {
                    ProgressView()
                }
            }
            .disabled(observable.viewModel.isSearching)
            .buttonStyle(.borderedProminent)
            FlightListView(flightsState: observable.viewModel.flightsState)
            Spacer()
        }
        .padding()
    }
}

private extension FlightsView {
    enum Constant {
        static let searchButtonTitle = "Search"
        static let fromTitle = "From: "
        static let toTitle = "To: "
        static let toDestinationName = "Kiwi's top places"
        static let selectedDateTitle = "Selected date: "
    }
}
