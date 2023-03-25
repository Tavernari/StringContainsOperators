//
//  OrSearchStrategy.swift
//  
//
//  Created by Victor C Tavernari on 23/03/2023.
//

import Foundation

/// OrSearchStrategy is a concrete class that represents a strategy to search for a string that contains at least one of a given array of strings.
final class OrSearchStrategy: SearchStrategy {

    /// An array of StringPredicateInputKind to search.
    let input: [StringPredicateInputKind]

    /// Initializes an instance of `OrSearchStrategy`.
    /// - Parameter input: An array of StringPredicateInputKind to search.
    init(input: [StringPredicateInputKind]) {

        self.input = input
    }

    /// Evaluates if a given string contains at least one of the strings in `strings`.
    /// - Parameter string: The string to search.
    /// - Returns: `true` if the string contains at least one of the strings in `strings`, `false` otherwise.
    func evaluate(string: String) throws -> Bool {

        try self.input.contains { inputKind in

            switch inputKind {

            case let .string(value):
                return string.contains(value)

            case let .predicate(predicate):
                return try string.contains(predicate)
            }
        }
    }
}
