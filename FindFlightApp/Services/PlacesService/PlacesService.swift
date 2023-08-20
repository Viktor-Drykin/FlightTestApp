//
//  PlacesService.swift
//  FlightTestApp
//
//  Created by Viktor Drykin on 17.08.2023.
//

import Foundation

protocol PlacesServiceProtocol: AnyObject {

    var originPlaces: [Node] { get }

    func fetchPlaces(with text: String) async -> Result<[Node], Error>
}

class PlacesService {

    let apiService: APIServicePerformable
    let url: URL

    init(apiService: APIServicePerformable, url: URL) {
        self.apiService = apiService
        self.url = url
    }
}

extension PlacesService: PlacesServiceProtocol {

    func fetchPlaces(with text: String) async -> Result<[Node], Error> {

        let operation = GraphQLOperation<PlacesInput, Places>(
            url: url,
            input: PlacesInput(term: text),
            operationString: placesQueryBody
        )

        do {
            let places = try await apiService.perform(operation)
            return places.map { $0.edges.map { $0.node } }
        } catch {
            return .failure(error)
        }
    }

    var originPlaces: [Node] {
        [
            .init(id: "City:brno_cz", legacyID: "brno_cz", name: "Brno", gps: .init(lat: 49.19506, lng: 16.606837)),
            .init(id: "City:prague_cz", legacyID: "prague_cz", name: "Prague", gps: .init(lat: 50.075538, lng: 14.4378)),
            .init(id: "City:vienna_at", legacyID: "vienna_at", name: "Vienna", gps: .init(lat: 48.208174, lng: 16.373819))
        ]
    }
}
