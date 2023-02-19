//
//  File.swift
//  
//
//  Created by Blaine Oelkers on 19/02/2023.
//

import Foundation

extension HistoricalDataManager {
    class Cache {
        var scheduleCache: [HistoricalDataManager.SupportedYear: Schedule] = [:]

        func schedule(for year: HistoricalDataManager.SupportedYear) -> Schedule? {
            scheduleCache[year]
        }

        func cache(schedule: Schedule, for year: HistoricalDataManager.SupportedYear) {
            scheduleCache[year] = schedule
        }

        func clear(year: HistoricalDataManager.SupportedYear) {
            scheduleCache.removeValue(forKey: year)
        }

        func clear() {
            scheduleCache = [:]
        }
    }
}
