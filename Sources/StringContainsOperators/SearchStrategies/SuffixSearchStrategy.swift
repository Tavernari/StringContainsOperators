//
//  SuffixSearchStrategy.swift
//  
//
//  Created by Victor C Tavernari on 23/03/2023.
//

import Foundation

/// `SuffixSearchStrategy` is a type of `SearchStrategy` that searches for a `String` that ends with a given value.
final class SuffixSearchStrategy: SearchStrategy {

    enum InternalError: Error {
        case notAvailableToPredicates
    }

    /// An StringPredicateInputKind to search.
    let input: StringPredicateInputKind

    /// Initializes an instance of `SuffixSearchStrategy`.
    /// - Parameter input: An StringPredicateInputKind to search.
    init(input: StringPredicateInputKind) {
        self.input = input
    }

    /// Evaluates if a given string ends with the `value` string.
    ///
    /// - Parameter string: The string to be evaluated.
    /// - Returns: `true` if the string ends with the `value` string, `false` otherwise.
    func evaluate(string: String) throws -> Bool {
        switch self.input {
        case let .string(value):
            return string.hasSuffix(value)

        case .predicate:
            throw InternalError.notAvailableToPredicates
        }
    }
}
