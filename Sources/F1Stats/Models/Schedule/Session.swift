//
//  File.swift
//  
//
//  Created by Blaine Oelkers on 19/02/2023.
//

import Foundation

public extension Schedule.Event {
    /// Describes one of the sessions during an event
    struct Session: Codable, CustomStringConvertible {
        /// The format for the session
        var format: Session.Format

        /// The date of the session
        var date: Date

        public var description: String {
            """
            Session Format: \(format.description)
            Date: \(DateFormatter.longDate.string(from: date))
            """
        }
    }
}

extension Collection where Element == Schedule.Event.Session {
    var fullDescription: String {
        var description = "Sessions:\n"
        for session in self {
            description += session.description + "\n"
        }
        description.removeLast()
        return description
    }
}
