//
//  PlacesQueryBody.swift
//  FindFlight
//
//  Created by Viktor Drykin on 18.08.2023.
//

import Foundation

let placesQueryBody =
            """
            query places($term: String) {
                    places(
                        search: { term: $term },
                        filter: {
                            onlyTypes: [AIRPORT, CITY],
                            groupByCity: true
                        },
                        options: { sortBy: RANK },
                        first: 20
            ){
            ... on PlaceConnection {
                            edges { node { id legacyId name gps { lat lng } } }
                        }
            } }
            """
