//
//  AndSearchStrategy.swift
//  
//
//  Created by Victor C Tavernari on 23/03/2023.
//

import Foundation

/// `AndSearchStrategy` is a type of `SearchStrategy` that searches for multiple `String`s with an "AND" condition.
final class AndSearchStrategy: SearchStrategy {

    /// An array of StringPredicateInputKind to search.
    let input: [StringPredicateInputKind]

    /// Initializes an instance of `AndSearchStrategy`.
    /// - Parameter input: An array of StringPredicateInputKind to search.
    init(input: [StringPredicateInputKind]) {

        self.input = input
    }

    /// Evaluates if a given string contains all of the `String`s in the `strings` array.
    ///
    /// - Parameter string: The string to be evaluated.
    /// - Returns: `true` if the string contains all of the `String`s in the `strings` array, `false` otherwise.
    func evaluate(string: String) throws -> Bool {

        try self.input.allSatisfy { inputKind in

            switch inputKind {

            case let .string(value):
                return string.contains(value)

            case let .predicate(predicate):
                return try string.contains(predicate)
            }
        }
    }
}
