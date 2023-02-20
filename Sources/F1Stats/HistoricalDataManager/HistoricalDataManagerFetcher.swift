//
//  File.swift
//  
//
//  Created by Blaine Oelkers on 19/02/2023.
//

import Foundation

class HistoricalDataManagerFetcher {
    public enum Error: LocalizedError {
        case unknownURL
        case noDataReturned
        case couldNotParseSchedule
        case somethingTerribleHasHappened
    }

    static var tasks = [URLSessionDataTask]()

    static func fetch(_ year: HistoricalDataManager.SupportedYear) async throws -> Schedule {
        try await withCheckedThrowingContinuation { continuation in
            guard let url = URL(string: "https://raw.githubusercontent.com/theOehrly/f1schedule/master/schedule_\(year.rawValue).json") else {
                continuation.resume(throwing: Self.Error.unknownURL)
                return
            }
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    if let error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(throwing: Self.Error.somethingTerribleHasHappened)
                    }
                    return
                }
                guard let data else {
                    continuation.resume(throwing: Self.Error.noDataReturned)
                    return
                }
                do {
                    let oehrlySchedule = try JSONDecoder().decode(OehrlySchedule.self, from: data)
                    continuation.resume(returning: Schedule(oehrlySchedule: oehrlySchedule))
                } catch {
                    continuation.resume(throwing: error)
                }
            }
            task.resume()
            Self.tasks.append(task)
        }
    }
}
