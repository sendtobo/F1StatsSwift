//
//  Schedule.swift
//  
//
//  Created by Blaine Oelkers on 19/02/2023.
//

import Foundation

/// Describes a full calendar schedule
public struct Schedule: Codable, CustomStringConvertible {
    /// All of the events for this year
    public var events: [Event]

    public var description: String {
        var description = ""
        for event in events {
            description += "----------------------\n"
            description += event.description + "\n"
        }
        return description
    }

    init(events: [Event]) {
        self.events = events
    }

    init(oehrlySchedule: OehrlySchedule) {
        var events = [Event]()
        for roundNumberKey in oehrlySchedule.roundNumber.keys {
            // If any item is missing we just skip that item
            guard let roundNumber = oehrlySchedule.roundNumber[roundNumberKey] else {
                continue
            }
            guard let country = oehrlySchedule.country[roundNumberKey] else {
                continue
            }
            guard let innerLocation = oehrlySchedule.location[roundNumberKey] else {
                continue
            }
            let location = Schedule.Event.Location(country: country,
                                                   location: innerLocation)
            guard let eventDate = oehrlySchedule.eventDate[roundNumberKey] else {
                continue
            }
            guard let rawFormat = oehrlySchedule.eventFormat[roundNumberKey] else {
                continue
            }
            let format = Event.Format(rawValue: rawFormat)
            var sessions = [Event.Session]()
            if let sessionRawValue = oehrlySchedule.session1[roundNumberKey] {
                if let sessionDate = oehrlySchedule.session1Date[roundNumberKey],
                   let sessionRawValue, let sessionDate {
                    sessions.append(.init(format: .init(rawValue: sessionRawValue),
                                          date: sessionDate))
                }
            }
            if let sessionRawValue = oehrlySchedule.session2[roundNumberKey] {
                if let sessionDate = oehrlySchedule.session2Date[roundNumberKey],
                   let sessionRawValue, let sessionDate {
                    sessions.append(.init(format: .init(rawValue: sessionRawValue),
                                          date: sessionDate))
                }
            }
            if let sessionRawValue = oehrlySchedule.session3[roundNumberKey] {
                if let sessionDate = oehrlySchedule.session3Date[roundNumberKey],
                   let sessionRawValue, let sessionDate {
                    sessions.append(.init(format: .init(rawValue: sessionRawValue),
                                          date: sessionDate))
                }
            }
            if let sessionRawValue = oehrlySchedule.session4[roundNumberKey] {
                if let sessionDate = oehrlySchedule.session4Date[roundNumberKey],
                   let sessionRawValue, let sessionDate {
                    sessions.append(.init(format: .init(rawValue: sessionRawValue),
                                          date: sessionDate))
                }
            }
            if let sessionRawValue = oehrlySchedule.session5[roundNumberKey] {
                if let sessionDate = oehrlySchedule.session5Date[roundNumberKey],
                   let sessionRawValue, let sessionDate {
                    sessions.append(.init(format: .init(rawValue: sessionRawValue),
                                          date: sessionDate))
                }
            }
            guard let officialName = oehrlySchedule.officialEventName[roundNumberKey] else {
                continue
            }
            guard let commonName = oehrlySchedule.eventName[roundNumberKey] else {
                continue
            }
            let name = Schedule.Event.Name(officalName: officialName, commonName: commonName)
            guard let f1APISupport = oehrlySchedule.f1APISupport[roundNumberKey] else {
                continue
            }
            events.append(.init(roundNumber: roundNumber,
                                location: location,
                                name: name,
                                eventDate: eventDate,
                                format: format,
                                sessions: sessions,
                                f1APISupport: f1APISupport))
        }
        self.events = events.sorted(by: {
            // We sort by round numbe and then by event date if there are two with the same round number (usually only happens with testing)
            if $0.roundNumber < $1.roundNumber {
                return true
            } else if $0.roundNumber > $1.roundNumber {
                return false
            } else {
                return $0.eventDate < $1.eventDate
            }
        })
    }
}
