//
//  File.swift
//  
//
//  Created by Blaine Oelkers on 19/02/2023.
//

import Foundation

/// Describes one of the sessions during an event
public struct EventSession: Codable, CustomStringConvertible {
    /// The format for the session
    public var format: SessionFormat

    /// The date of the session
    public var date: Date

    public var description: String {
            """
            Session Format: \(format.description)
            Date: \(DateFormatter.longDate.string(from: date))
            """
    }
}

extension Collection where Element == EventSession {
    var fullDescription: String {
        var description = "Sessions:\n"
        for session in self {
            description += session.description + "\n"
        }
        description.removeLast()
        return description
    }
}
