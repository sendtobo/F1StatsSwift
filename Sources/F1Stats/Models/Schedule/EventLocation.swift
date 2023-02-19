//
//  File.swift
//  
//
//  Created by Blaine Oelkers on 19/02/2023.
//

import Foundation

public extension Schedule.Event {
    /// Describes the location of the event
    struct Location: Codable, CustomStringConvertible {
        /// The country in which the event is taking place
        public var country: String
        /// Very often the city or raceway the event takes place, but could be anything
        public var location: String

        public var description: String {
            """
            Country: \(country)
            Location: \(location)
            """
        }
    }
}
