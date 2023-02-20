//
//  File.swift
//  
//
//  Created by Blaine Oelkers on 19/02/2023.
//

import Foundation

/// Describes the format of the entire event
public enum EventFormat: Codable, CustomStringConvertible, Equatable {
    /// Typical describes event formats befor the start of the season
    case testing
    /// A typical F1 Grand Prix with Practice sessions, Qualifying, and a Race
    case conventional
    /// An F1 Grad Prix that includes a sprint race
    case sprint
    /// Some unknown event
    case unknown(String)

    public var description: String {
        switch self {
        case .testing:
            return "Testing"
        case .conventional:
            return "Conventional"
        case .sprint:
            return "Sprint"
        case .unknown(let format):
            return "Unknown: \(format)"
        }
    }

    init(rawValue: String) {
        switch rawValue {
        case "testing":
            self = .testing
        case "conventional":
            self = .conventional
        case "sprint":
            self = .sprint
        default:
            self = .unknown(rawValue)
        }
    }

    public static func == (lhs: EventFormat, rhs: EventFormat) -> Bool {
        switch (lhs, rhs) {
        case (.testing, .testing),
            (.conventional, .conventional),
            (.sprint, .sprint):
            return true
        case (.unknown(let lhsUnknown), .unknown(let rhsUnknown)):
            return lhsUnknown == rhsUnknown
        default:
            return false
        }
    }
}
