//
//  HistoricalDataManager.swift
//  
//
//  Created by Blaine Oelkers on 19/02/2023.
//

import Foundation

public class HistoricalDataManager {
    public static var shared: HistoricalDataManager = .init()

    var cache = HistoricalDataManagerCache()

    public func getSchedule(year: SupportedYear,
                            includeTestingSession: Bool = true) async -> F1Stats.Schedule? {
        if let schedule = cache.schedule(for: year) {
            return schedule
        }
        do {
            let schedule = try await HistoricalDataManagerFetcher.fetch(year)
            cache.cache(schedule: schedule, for: year)
            return schedule
        } catch {
            print(error)
            return nil
        }
    }
}
