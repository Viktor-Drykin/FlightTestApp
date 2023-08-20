//
//  Builders.swift
//  FindFlightAppTests
//
//  Created by Viktor Drykin on 20.08.2023.
//

import Foundation

extension BookingOptions {

    public final class Builder {

        private var edges = [BookingOptionsEdge.Builder().build()]

        public init() {}

        public func with(edges: [BookingOptionsEdge]) -> Self {

            self.edges = edges
            return self
        }

        public func build() -> BookingOptions {

            return BookingOptions(
                edges: edges)
        }

    }

}

extension BookingOptionsEdge {

    public final class Builder {

        private var node = EdgeNode.Builder().build()

        public init() {}

        public func with(node: EdgeNode) -> Self {

            self.node = node
            return self
        }

        public func build() -> BookingOptionsEdge {

            return BookingOptionsEdge(
                node: node)
        }

    }

}

extension City {

    public final class Builder {


        private var id = ""
        private var legacyID = ""
        private var name = ""
        private var country = Country.Builder().build()

        public init() {}

        public func with(id: String) -> Self {

            self.id = id
            return self
        }

        public func with(legacyID: String) -> Self {

            self.legacyID = legacyID
            return self
        }

        public func with(name: String) -> Self {

            self.name = name
            return self
        }

        public func with(country: Country) -> Self {

            self.country = country
            return self
        }

        public func build() -> City {

            return City(
                id: id,
                legacyID: legacyID,
                name: name,
                country: country)
        }

    }

}

extension Country {

    public final class Builder {

        private var id = ""
        private var name = ""

        public init() {}

        public func with(id: String) -> Self {

            self.id = id
            return self
        }

        public func with(name: String) -> Self {

            self.name = name
            return self
        }

        public func build() -> Country {

            return Country(
                id: id,
                name: name)
        }

    }

}

extension Destination {

    public final class Builder {

        private var utcTime = ""
        private var localTime = ""
        private var station = Station.Builder().build()

        public init() {}

        public func with(utcTime: String) -> Self {

            self.utcTime = utcTime
            return self
        }

        public func with(localTime: String) -> Self {

            self.localTime = localTime
            return self
        }

        public func with(station: Station) -> Self {

            self.station = station
            return self
        }

        public func build() -> Destination {

            return Destination(
                utcTime: utcTime,
                localTime: localTime,
                station: station)
        }

    }

}

extension EdgeNode {

    public final class Builder {

        private var bookingURL = ""
        private var price: Price = Price.Builder().build()

        public init() {}

        public func with(bookingURL: String) -> Self {

            self.bookingURL = bookingURL
            return self
        }

        public func with(price: Price) -> Self {

            self.price = price
            return self
        }

        public func build() -> EdgeNode {

            return EdgeNode(
                bookingURL: bookingURL,
                price: price)
        }

    }

}

extension Itinerary {

    public final class Builder {

        private var id = ""
        private var duration = 0
        private var cabinClasses: [CabinClass] = [.economy]
        private var priceEur = PriceEur.Builder().build()
        private var bookingOptions = BookingOptions.Builder().build()
        private var provider = Provider.Builder().build()
        private var sector = Sector.Builder().build()

        public init() {}

        public func with(id: String) -> Self {

            self.id = id
            return self
        }

        public func with(duration: Int) -> Self {

            self.duration = duration
            return self
        }

        public func with(cabinClasses: [CabinClass]) -> Self {

            self.cabinClasses = cabinClasses
            return self
        }

        public func with(priceEur: PriceEur) -> Self {

            self.priceEur = priceEur
            return self
        }

        public func with(bookingOptions: BookingOptions) -> Self {

            self.bookingOptions = bookingOptions
            return self
        }

        public func with(provider: Provider) -> Self {

            self.provider = provider
            return self
        }

        public func with(sector: Sector) -> Self {

            self.sector = sector
            return self
        }

        public func build() -> Itinerary {

            return Itinerary(
                id: id,
                duration: duration,
                cabinClasses: cabinClasses,
                priceEur: priceEur,
                bookingOptions: bookingOptions,
                provider: provider,
                sector: sector)
        }

    }

}

extension Layover {

    public final class Builder {

        private var duration = 0
        private var isBaggageRecheck = false
        private var transferDuration: Int? = nil
        private var transferType: String? = nil

        public init() {}

        public func with(duration: Int) -> Self {

            self.duration = duration
            return self
        }

        public func with(isBaggageRecheck: Bool) -> Self {

            self.isBaggageRecheck = isBaggageRecheck
            return self
        }

        public func with(transferDuration: Int?) -> Self {

            self.transferDuration = transferDuration
            return self
        }

        public func with(transferType: String?) -> Self {

            self.transferType = transferType
            return self
        }

        public func build() -> Layover {

            return Layover(
                duration: duration,
                isBaggageRecheck: isBaggageRecheck,
                transferDuration: transferDuration,
                transferType: transferType)
        }

    }

}

extension Price {

    public final class Builder {

        private var amount = ""
        private var formattedValue = ""

        public init() {}

        public func with(amount: String) -> Self {

            self.amount = amount
            return self
        }

        public func with(formattedValue: String) -> Self {

            self.formattedValue = formattedValue
            return self
        }

        public func build() -> Price {

            return Price(
                amount: amount,
                formattedValue: formattedValue)
        }

    }

}

extension PriceEur {

    public final class Builder {

        private var amount = ""

        public init() {}

        public func with(amount: String) -> Self {

            self.amount = amount
            return self
        }

        public func build() -> PriceEur {

            return PriceEur(
                amount: amount)
        }

    }

}

extension Provider {

    public final class Builder {

        private var id = ""
        private var name = ""
        private var code = ""

        public init() {}

        public func with(id: String) -> Self {

            self.id = id
            return self
        }

        public func with(name: String) -> Self {

            self.name = name
            return self
        }

        public func with(code: String) -> Self {

            self.code = code
            return self
        }

        public func build() -> Provider {

            return Provider(
                id: id,
                name: name,
                code: code)
        }

    }

}

extension Sector {

    public final class Builder {

        private var id = ""
        private var duration = 0
        private var sectorSegments = [SectorSegment.Builder().build()]

        public init() {}

        public func with(id: String) -> Self {

            self.id = id
            return self
        }

        public func with(duration: Int) -> Self {

            self.duration = duration
            return self
        }

        public func with(sectorSegments: [SectorSegment]) -> Self {

            self.sectorSegments = sectorSegments
            return self
        }

        public func build() -> Sector {

            return Sector(
                id: id,
                duration: duration,
                sectorSegments: sectorSegments)
        }

    }

}

extension SectorSegment {

    public final class Builder {

        private var segment = Segment.Builder().build()
        private var layover: Layover? = nil
        private var guarantee: Guarantee? = nil

        public init() {}

        public func with(segment: Segment) -> Self {

            self.segment = segment
            return self
        }

        public func with(layover: Layover?) -> Self {

            self.layover = layover
            return self
        }

        public func with(guarantee: Guarantee?) -> Self {

            self.guarantee = guarantee
            return self
        }

        public func build() -> SectorSegment {

            return SectorSegment(
                segment: segment,
                layover: layover,
                guarantee: guarantee)
        }
    }
}

extension Segment {

    public final class Builder {

        private var id = ""
        private var duration = 0
        private var type: SegmentType = .flight
        private var code = ""
        private var source = Destination.Builder().build()
        private var destination = Destination.Builder().build()
        private var carrier = Provider.Builder().build()
        private var operatingCarrier: Provider? = nil

        public init() {}

        public func with(id: String) -> Self {

            self.id = id
            return self
        }

        public func with(duration: Int) -> Self {

            self.duration = duration
            return self
        }

        public func with(type: SegmentType) -> Self {

            self.type = type
            return self
        }

        public func with(code: String) -> Self {

            self.code = code
            return self
        }

        public func with(source: Destination) -> Self {

            self.source = source
            return self
        }

        public func with(destination: Destination) -> Self {

            self.destination = destination
            return self
        }

        public func with(carrier: Provider) -> Self {

            self.carrier = carrier
            return self
        }

        public func with(operatingCarrier: Provider?) -> Self {

            self.operatingCarrier = operatingCarrier
            return self
        }

        public func build() -> Segment {

            return Segment(
                id: id,
                duration: duration,
                type: type,
                code: code,
                source: source,
                destination: destination,
                carrier: carrier,
                operatingCarrier: operatingCarrier)
        }

    }

}

extension Station {

    public final class Builder {

        private var id: String = ""
        private var name: String = ""
        private var code: String = ""
        private var type: StationType = .airport
        private var city = City.Builder().build()

        public init() {}

        public func with(id: String) -> Self {

            self.id = id
            return self
        }

        public func with(name: String) -> Self {

            self.name = name
            return self
        }

        public func with(code: String) -> Self {

            self.code = code
            return self
        }

        public func with(type: StationType) -> Self {

            self.type = type
            return self
        }

        public func with(city: City) -> Self {

            self.city = city
            return self
        }

        public func build() -> Station {

            return Station(
                id: id,
                name: name,
                code: code,
                type: type,
                city: city)
        }

    }

}

