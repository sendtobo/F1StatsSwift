//
//  File.swift
//  
//
//  Created by Blaine Oelkers on 19/02/2023.
//

import Foundation


extension Schedule.Event.Session {
    /// Describes the format of a specific session
    public enum Format: Codable, CustomStringConvertible, Equatable {
        /// A practice with the number being the practice number
        case practice(Int)
        /// A qaulifying format
        case qualifying
        /// A sprint format
        case sprint
        /// A full race format
        case race
        /// An unknown type of event
        case unknown(String)

        public var description: String {
            switch self {
            case .practice(let number):
                return "Practice \(number)"
            case .qualifying:
                return "Qualifying"
            case .sprint:
                return "Sprint"
            case .race:
                return "Race"
            case .unknown(let format):
                return "Unknown: \(format)"
            }
        }

        init(rawValue: String) {
            let parts = rawValue.split(separator: " ")
            switch parts[0] {
            case "Practice":
                if let practiceNumber = Int(parts[1]) {
                    self = .practice(practiceNumber)
                } else {
                    self = .unknown(rawValue)
                }
            case "Qualifying":
                self = .qualifying
            case "Sprint":
                self = .sprint
            case "Race":
                self = .race
            default:
                self = .unknown(rawValue)
            }
        }

        public static func == (lhs: Format, rhs: Format) -> Bool {
            switch (lhs, rhs) {
            case (.qualifying, .qualifying),
                (.sprint, .sprint),
                (.race, .race):
                return true
            case (.practice(let lhsNumber), .practice(let rhsNumber)):
                return lhsNumber == rhsNumber
            case (.unknown(let lhsUnknown), .unknown(let rhsUnknown)):
                return lhsUnknown == rhsUnknown
            default:
                return false
            }
        }
    }
}
