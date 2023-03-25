//
//  DiacriticAndCaseInsensitiveSearchStrategy.swift
//  
//
//  Created by Victor C Tavernari on 23/03/2023.
//

import Foundation

/// `DiacriticAndCaseInsensitiveSearchStrategy` is a type of `SearchStrategy` that searches for a `String` case-insensitively and without diacritics.
final class DiacriticAndCaseInsensitiveSearchStrategy: SearchStrategy {

    enum InternalError: Error {

        case notAvailableToPredicates
    }

    /// An StringPredicateInputKind to search.
    let input: StringPredicateInputKind

    /// Initializes an instance of `DiacriticAndCaseInsensitiveSearchStrategy`.
    /// - Parameter input: An StringPredicateInputKind to search.
    init(input: StringPredicateInputKind) {

        self.input = input
    }

    /// Evaluates if a given string contains the `value` string without diacritics and case-insensitively.
    ///
    /// - Parameter string: The string to be evaluated.
    /// - Returns: `true` if the string contains the `value` string without diacritics and case-insensitively, `false` otherwise.
    func evaluate(string: String) throws -> Bool {

        switch self.input {

        case let .string(value):
            let string = string.removeDiacriticsAndCase().lowercased()
            let value = value.removeDiacriticsAndCase().lowercased()
            return string.contains(value)

        case .predicate:
            throw InternalError.notAvailableToPredicates
        }
    }
}
