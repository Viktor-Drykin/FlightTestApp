//
//  FlightsScene.swift
//  FindFlight
//
//  Created by Viktor Drykin on 19.08.2023.
//

import Foundation

protocol FlightsScene: AnyObject {
    func perform(update: Flights.Update)
    func perform(action: Flights.Action)
}
