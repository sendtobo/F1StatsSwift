//
//  OehrlySchedule.swift
//  
//
//  Created by Blaine Oelkers on 19/02/2023.
//

import Foundation

/// We are using the schedule put together by https://github.com/theOehrly/f1schedule
struct OehrlySchedule: Codable {
    var roundNumber: [String: Int]
    var country: [String: String]
    var location: [String: String]
    var officialEventName: [String: String]
    var eventDate: [String: Date]
    var eventName: [String: String]
    var eventFormat: [String: String]
    var session1: [String: String?]
    var session1Date: [String: Date?]
    var session2: [String: String?]
    var session2Date: [String: Date?]
    var session3: [String: String?]
    var session3Date: [String: Date?]
    var session4: [String: String?]
    var session4Date: [String: Date?]
    var session5: [String: String?]
    var session5Date: [String: Date?]
    var f1APISupport: [String: Bool]

    enum CodingKeys: String, CodingKey {
        case roundNumber = "round_number"
        case country
        case location
        case officialEventName = "official_event_name"
        case eventDate = "event_date"
        case eventName = "event_name"
        case eventFormat = "event_format"
        case session1
        case session1Date = "session1_date"
        case session2
        case session2Date = "session2_date"
        case session3
        case session3Date = "session3_date"
        case session4
        case session4Date = "session4_date"
        case session5
        case session5Date = "session5_date"
        case f1APISupport = "f1_api_support"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        roundNumber = try container.decode([String: Int].self, forKey: .roundNumber)
        country = try container.decode([String: String].self, forKey: .country)
        location = try container.decode([String: String].self, forKey: .location)
        officialEventName = try container.decode([String: String].self, forKey: .officialEventName)
        eventName = try container.decode([String: String].self, forKey: .eventName)
        eventFormat = try container.decode([String: String].self, forKey: .eventFormat)
        session1 = try container.decode([String: String?].self, forKey: .session1)
        session2 = try container.decode([String: String?].self, forKey: .session2)
        session3 = try container.decode([String: String?].self, forKey: .session3)
        session4 = try container.decode([String: String?].self, forKey: .session4)
        session5 = try container.decode([String: String?].self, forKey: .session5)
        f1APISupport = try container.decode([String: Bool].self, forKey: .f1APISupport)

        let eventDateStrings = try container.decode([String: String].self, forKey: .eventDate)
        let session1DateStrings = try container.decode([String: String?].self, forKey: .session1Date)
        let session2DateStrings = try container.decode([String: String?].self, forKey: .session2Date)
        let session3DateStrings = try container.decode([String: String?].self, forKey: .session3Date)
        let session4DateStrings = try container.decode([String: String?].self, forKey: .session4Date)
        let session5DateStrings = try container.decode([String: String?].self, forKey: .session5Date)

        eventDate = Self.convertStringToDate(eventDateStrings)
        session1Date = Self.convertStringToDate(session1DateStrings)
        session2Date = Self.convertStringToDate(session2DateStrings)
        session3Date = Self.convertStringToDate(session3DateStrings)
        session4Date = Self.convertStringToDate(session4DateStrings)
        session5Date = Self.convertStringToDate(session5DateStrings)
    }

    private static func convertStringToDate(_ stringArray: [String: String?]) -> [String: Date] {
        stringArray.compactMap { (key, value) -> (String, Date)? in
            guard let value else { return nil }
            if let date = DateFormatter.shortDate.date(from: value) {
                return (key, date)
            }
            if let date = DateFormatter.longDate.date(from: value) {
                return (key, date)
            }
            return nil
        }.reduce(into: [String: Date]()) { $0[$1.0] = $1.1 }
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
