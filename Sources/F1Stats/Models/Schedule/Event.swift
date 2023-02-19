//
//  Event.swift
//  
//
//  Created by Blaine Oelkers on 19/02/2023.
//

import Foundation

extension Schedule {
    /// A F1 Event
    public struct Event: Codable, CustomStringConvertible {
        /// The position in the calendar
        public var roundNumber: Int

        /// The location of the event
        public var location: Location

        /// The name of the event
        public var name: Name

        /// The offical start time of the main part of the event
        public var eventDate: Date

        /// The format for the event
        public var format: Self.Format

        /// All off the session from practice to race
        public var sessions: [Event.Session]

        /// Is supported by the F1 API
        public var f1APISupport: Bool

        public var description: String {
            """
            Round Number: \(roundNumber)
            \(location.description)
            \(name.description)
            Event Date: \(DateFormatter.longDate.string(from: eventDate))
            Format: \(format.description)
            \(sessions.fullDescription)
            F1 API Support: \(f1APISupport)
            """
        }
    }
}
