//
//  HistoricalDataManagerCacheSpec.swift
//  
//
//  Created by Blaine Oelkers on 19/02/2023.
//

import Foundation
import Nimble
import Quick

@testable import F1Stats

class HistoricalDataManagerCacheSpec: QuickSpec {
    override func spec() {
        describe("HistoricalDataManagerCacheSpec") {
            it("save into cache") {
                let cache = HistoricalDataManagerCache()
                let schedule = Schedule(events: [])
                expect(cache.schedule(for: .y2022)) == nil
                cache.cache(schedule: schedule, for: .y2022)
                expect(cache.schedule(for: .y2022)) != nil
            }
            it("clear cache for single year") {
                let cache = HistoricalDataManagerCache()
                let schedule = Schedule(events: [])
                cache.cache(schedule: schedule, for: .y2022)
                expect(cache.schedule(for: .y2022)) != nil
                cache.clear(year: .y2022)
                expect(cache.schedule(for: .y2022)) == nil
            }
            it("clear full cache") {
                let cache = HistoricalDataManagerCache()
                let schedule = Schedule(events: [])
                cache.cache(schedule: schedule, for: .y2022)
                cache.cache(schedule: schedule, for: .y2021)
                expect(cache.schedule(for: .y2022)) != nil
                expect(cache.schedule(for: .y2021)) != nil
                cache.clear()
                expect(cache.schedule(for: .y2022)) == nil
                expect(cache.schedule(for: .y2021)) == nil
            }
        }
    }
}
