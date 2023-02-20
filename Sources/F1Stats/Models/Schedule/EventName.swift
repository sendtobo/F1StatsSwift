//
//  File.swift
//  
//
//  Created by Blaine Oelkers on 19/02/2023.
//

import Foundation

// Describes the name of the event
public struct EventName: Codable, CustomStringConvertible {
    /// The official name of the event
    public var officalName: String

    /// The name most people use to refer to the event
    public var commonName: String

    public var description: String {
            """
            Official Name: \(officalName)
            Common Name: \(commonName)
            """
    }
}
