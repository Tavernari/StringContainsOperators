//
//  NegatableValueSearchStrategy.swift
//  
//
//  Created by Victor C Tavernari on 24/03/2023.
//

import Foundation

/// A search strategy that negates the presence of a given value in a string.
final class NegatableSearchStrategy: SearchStrategy {

    /// An StringPredicateInputKind to search.
    let input: StringPredicateInputKind

    /// Initializes an instance of `NegatableSearchStrategy`.
    /// - Parameter input: An StringPredicateInputKind to search.
    init(input: StringPredicateInputKind) {

        self.input = input
    }

    /// Evaluates the given string with the negated value search strategy.
    ///
    /// - Parameter string: The string to be evaluated.
    /// - Returns: `true` if the given string does not contain the value, `false` otherwise.
    func evaluate(string: String) throws  -> Bool {

        switch self.input {

        case let .string(value):
            return !string.contains(value)

        case let .predicate(predicate):
            return try !string.contains(predicate)
        }
    }
}

