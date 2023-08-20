//
//  FlightItemView.swift
//  FindFlight
//
//  Created by Viktor Drykin on 20.08.2023.
//

import SwiftUI

struct FlightItemView: View {

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm, dd MMM"
        return dateFormatter
    }()

    let flight: Flights.ViewModel.Flight
    let imageWidth: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: flight.imageURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageWidth)

                } else {
                    ZStack(alignment: .center) {
                        Image("placeholder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: imageWidth)
                        if phase.error != nil {
                            ProgressView()
                        }
                    }
                }

            }
            VStack(alignment: .leading) {
                Text(Constant.fromTitle + flight.origin)
                    .fontWeight(.bold)
                Text(Constant.toTitle + flight.destination)
                    .fontWeight(.bold)
                if let price = flight.price {
                    Text(price)
                        .bold()
                        .foregroundColor(.green)
                }
                if let date = flight.date {
                    Text(Self.dateFormatter.string(from: date))
                        .bold()
                        .foregroundColor(.blue)
                }
            }
            .padding(8)
        }
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, lineWidth: 1)
        )
    }

}

private extension FlightItemView {
    enum Constant {
        static let fromTitle = "From: "
        static let toTitle = "To: "
    }
}
