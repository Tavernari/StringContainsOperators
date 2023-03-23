//
//  OrSearchStrategy.swift
//  
//
//  Created by Victor C Tavernari on 23/03/2023.
//

import Foundation

/// OrSearchStrategy is a concrete class that represents a strategy to search for a string that contains at least one of a given array of strings.
final class OrSearchStrategy: SearchStrategy {

    /// An array of strings to search.
    let strings: [String]

    /// Initializes an instance of `OrSearchStrategy`.
    /// - Parameter strings: An array of strings to search.
    init(strings: [String]) {

        self.strings = strings
    }

    /// Evaluates if a given string contains at least one of the strings in `strings`.
    /// - Parameter string: The string to search.
    /// - Returns: `true` if the string contains at least one of the strings in `strings`, `false` otherwise.
    func evaluate(string: String) -> Bool {

        self.strings.contains(where: string.contains)
    }
}
