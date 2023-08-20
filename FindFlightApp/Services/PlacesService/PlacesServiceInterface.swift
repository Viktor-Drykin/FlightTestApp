//
//  PlacesServiceInterface.swift
//  FindFlightApp
//
//  Created by Viktor Drykin on 20.08.2023.
//

import Foundation

protocol PlacesServiceProtocol: AnyObject {

    var originPlaces: [Node] { get }

    func fetchPlaces(with text: String) async -> Result<[Node], Error>
}
