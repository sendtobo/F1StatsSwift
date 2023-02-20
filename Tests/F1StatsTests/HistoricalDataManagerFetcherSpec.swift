//
//  File.swift
//  
//
//  Created by Blaine Oelkers on 19/02/2023.
//

import Foundation
import Quick
import Nimble

@testable import F1Stats

class HistoricalDataManagerFetcherSpec: QuickSpec {
    override func spec() {
        describe("HistoricalDataManger.Fetcher") {
            it("can fetch year") {
                let schedule = try! await HistoricalDataManagerFetcher.fetch(.y2022)
                let bahrainTesting = schedule.events[1]
                expect(bahrainTesting.roundNumber) == 0
                expect(bahrainTesting.location.country) == "Bahrain"
                expect(bahrainTesting.location.location) == "Bahrain"
                expect(bahrainTesting.name.officalName) == "FORMULA 1 ARAMCO PRE-SEASON TESTING 2022"
                expect(bahrainTesting.name.commonName) == "Pre-Season Test"
                expect(bahrainTesting.format) == .testing
                expect(DateFormatter.longDate.string(from: bahrainTesting.eventDate)) == "2022-03-12T19:00:00"
                expect(bahrainTesting.f1APISupport) == true

                let session1 = bahrainTesting.sessions[0]
                expect(session1.format) == .practice(1)
                expect(DateFormatter.longDate.string(from: session1.date)) == "2022-03-10T10:00:00"
                let session2 = bahrainTesting.sessions[1]
                expect(session2.format) == .practice(2)
                expect(DateFormatter.longDate.string(from: session2.date)) == "2022-03-11T10:00:00"
                let session3 = bahrainTesting.sessions[2]
                expect(session3.format) == .practice(3)
                expect(DateFormatter.longDate.string(from: session3.date)) == "2022-03-12T10:00:00"
            }
        }
    }
}

extension DateFormatter {
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        return formatter
    }()

    static let longDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.calendar = Calendar(identifier: .iso8601)
        return formatter
    }()
}
