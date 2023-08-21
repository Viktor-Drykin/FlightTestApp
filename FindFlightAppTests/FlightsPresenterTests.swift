//
//  FlightsPresenterTests.swift
//  FindFlightAppTests
//
//  Created by Viktor Drykin on 20.08.2023.
//

import Foundation
import XCTest

class FlightsPresenterTests: XCTestCase {

    private var sut: FlightsPresenter!
    private var placesService: PlacesServiceMock!
    private var flightsProvider: FlightsProviderMock!

    override func setUp() {
        placesService = PlacesServiceMock()
        flightsProvider = FlightsProviderMock()
        sut = FlightsPresenter(placesService: placesService, flightsProvider: flightsProvider)
    }

    func test_viewModelWithError_whenUndefinedError_setUnknownErrorViewModel() {
        // Given
        let error = NetworkError.unknown

        // When
        let viewModel = sut.viewModel(with: error)

        // Then
        guard case .error(let type) = viewModel.flightsState else {
            XCTFail("Unexpected error state")
            return
        }
        XCTAssertEqual(type, .unknown)
    }

    func test_viewModelWithError_whenFailedToDecodeError_setDecodingErrorViewModel() {
        // Given
        let error = NetworkError.failedToDecode

        // When
        let viewModel = sut.viewModel(with: error)

        // Then
        guard case .error(let type) = viewModel.flightsState else {
            XCTFail("Unexpected error state")
            return
        }
        XCTAssertEqual(type, .decoding)
    }

    func test_viewModelWithError_whenInvalidStatusCodeError_setServerErrorViewModel() {
        // Given
        let error = NetworkError.invalidStatusCode

        // When
        let viewModel = sut.viewModel(with: error)

        // Then
        guard case .error(let type) = viewModel.flightsState else {
            XCTFail("Unexpected error state")
            return
        }
        XCTAssertEqual(type, .server)
    }

    func test_searchFlights_whenfetchPlacesFails_setErrorForViewModel() async {
        // Given
        placesService.result = .failure(ErrorMock.mocked)

        // When
        await sut.searchFlights(for: Date.now)

        // Then
        guard case .error(let type) = sut.viewModel.flightsState else {
            XCTFail("Unexpected error state")
            return
        }
        XCTAssertEqual(type, .unknown)
    }

    func test_searchFlights_whenFetchFlightsFails_ErrorForViewModel() async {
        // Given
        placesService.result = .success([])
        flightsProvider.result = .failure(NetworkError.failedToDecode)

        // When
        await sut.searchFlights(for: Date.now)

        // Then
        guard case .error(let type) = sut.viewModel.flightsState else {
            XCTFail("Unexpected error state")
            return
        }
        XCTAssertEqual(type, .decoding)
    }

    func test_searchFlights_whenRequestsSuccessful_setViewModelWithFlights() async {
        // Given
        placesService.result = .success([])
        flightsProvider.result = .success([.init(source: .init(code: "", name: "", legacyId: "", id: ""), destination: .init(code: "", name: "", legacyId: "", id: ""), date: Date.now, price: "")])

        // When
        await sut.searchFlights(for: Date.now)

        // Then
        guard case .loaded(let flights) = sut.viewModel.flightsState else {
            XCTFail("Unexpected flight State")
            return
        }

        XCTAssertEqual(sut.viewModel.isSearching, false)
        XCTAssertEqual(flights.count, 1)
    }
}


