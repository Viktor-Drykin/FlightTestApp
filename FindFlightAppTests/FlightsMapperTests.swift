//
//  FlightsMapperTests.swift
//  FindFlightAppTests
//
//  Created by Viktor Drykin on 20.08.2023.
//

import Foundation
import XCTest

class FlightsMapperTests: XCTestCase {

    func test_map_whenItineraryContainsSectorSegments_returnsViewModel() throws {
        let cityOrigin = City.Builder()
            .with(name: "origin")
            .build()
        let cityDestination = City.Builder()
            .with(legacyID: "destinationLegacyId")
            .build()
        let stationOrigin = Station.Builder()
            .with(city: cityOrigin)
            .build()
        let stationDestination = Station.Builder()
            .with(name: "destination")
            .with(city: cityDestination)
            .build()

        let source = Destination.Builder()
            .with(station: stationOrigin)
            .build()
        let destination = Destination.Builder()
            .with(station: stationDestination)
            .build()
        let segment = Segment.Builder()
            .with(source: source)
            .with(destination: destination)
            .build()
        let sectorSegment = SectorSegment.Builder()
            .with(segment: segment)
            .build()
        let sector = Sector.Builder()
            .with(sectorSegments: [sectorSegment])
            .build()
        let itinerary = Itinerary.Builder()
            .with(sector: sector)
            .build()

        let viewModel = try XCTUnwrap(FlightsModelMapper.map(itinerary: itinerary, dateFormatter: DateFormatter()))
        //TODO: add checks for viewModel content
    }
}
