//
//  FlightsQueryBody.swift
//  FindFlight
//
//  Created by Viktor Drykin on 19.08.2023.
//

import Foundation

let flightsQueryBody = """
fragment stopDetails on Stop {
  utcTime
  localTime
  station { id name code type city { id legacyId name country { id name } } }
}
query onewayItineraries($startDate: DateTime, $endDate: DateTime, $sourceIds: [String], $destinationIds: [String]) {
  onewayItineraries(
    filter: {
      allowChangeInboundSource: false, allowChangeInboundDestination: false,
      allowDifferentStationConnection: true, allowOvernightStopover: true,
      contentProviders: [KIWI], limit: 10, showNoCheckedBags: true,
      transportTypes: [FLIGHT]
    }, options: {
      currency: "EUR", partner: "skypicker", sortBy: QUALITY,
      sortOrder: ASCENDING, sortVersion: 4, storeSearch: true
    }, search: {
      cabinClass: { applyMixedClasses: true, cabinClass: ECONOMY },
      itinerary: {
        source: { ids: $sourceIds },
        destination: { ids: $destinationIds },
        outboundDepartureDate: {
          start: $startDate,
          end: $endDate
} },
      passengers: { adults: 1, adultsHandBags: [1], adultsHoldBags: [0] }
    }
){
... on Itineraries {
      itineraries {
        ... on ItineraryOneWay {
          id duration cabinClasses priceEur { amount }
          bookingOptions {
edges {
              node { bookingUrl price { amount formattedValue } }
            }
          }
          provider { id name code }
          sector {
            id duration
            sectorSegments {
              segment {
                id duration type code
                source { ...stopDetails }
                destination { ...stopDetails }
                carrier { id name code }
                operatingCarrier { id name code }
              }
              layover { duration isBaggageRecheck transferDuration transferType }
              guarantee
} }
} }
} }
}
"""
