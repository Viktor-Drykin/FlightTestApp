//
//  FlightsPresenting.swift
//  FindFlight
//
//  Created by Viktor Drykin on 19.08.2023.
//

import Foundation

protocol FlightsPresenting: AnyObject {

    var viewModel: Flights.ViewModel { get }

    func searchFlights(for date: Date) async
}
