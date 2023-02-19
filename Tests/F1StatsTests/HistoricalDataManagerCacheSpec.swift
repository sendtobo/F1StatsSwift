//
//  HistoricalDataManagerCacheSpec.swift
//  
//
//  Created by Blaine Oelkers on 19/02/2023.
//

import Foundation
import Quick
import Nimble

@testable import F1Stats

class HistoricalDataManagerCacheSpec: QuickSpec {
    override func spec() {
        describe("HistoricalDataManagerCacheSpec") {
            it("save into cache") {
                let cache = HistoricalDataManager.Cache()
                let schedule = Schedule(events: [])
                expect(cache.schedule(for: .y2022)).to(beNil())
                cache.cache(schedule: schedule, for: .y2022)
                expect(cache.schedule(for: .y2022)).toNot(beNil())
            }
            it("clear cache for single year") {
                let cache = HistoricalDataManager.Cache()
                let schedule = Schedule(events: [])
                cache.cache(schedule: schedule, for: .y2022)
                expect(cache.schedule(for: .y2022)).toNot(beNil())
                cache.clear(year: .y2022)
                expect(cache.schedule(for: .y2022)).to(beNil())
            }
            it("clear full cache") {
                let cache = HistoricalDataManager.Cache()
                let schedule = Schedule(events: [])
                cache.cache(schedule: schedule, for: .y2022)
                cache.cache(schedule: schedule, for: .y2021)
                expect(cache.schedule(for: .y2022)).toNot(beNil())
                expect(cache.schedule(for: .y2021)).toNot(beNil())
                cache.clear()
                expect(cache.schedule(for: .y2022)).to(beNil())
                expect(cache.schedule(for: .y2021)).to(beNil())
            }
        }
    }
}
