//
//  Identifier.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/19/23.
//

import Foundation

// Type-safety identifier to prevent lookup of 'TypeT' model using 'TypeV' identifier
struct Identifier<T>: Hashable, Codable, ExpressibleByStringLiteral, CustomStringConvertible {
    let string: String
    
    // Description String to print
    var description: String {
        return string
    }
    
    // Initialize an Identifer using single a String
    init(stringLiteral value: String) {
        string = value
    }
    
    // Decode/Encode an Identifier value using single a String
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.string = try container.decode(String.self)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(string)
    }
}
