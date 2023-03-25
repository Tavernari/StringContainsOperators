//
//  RegexSearchStrategy.swift
//  
//
//  Created by Victor C Tavernari on 24/03/2023.
//

import Foundation

/// A search strategy that evaluates whether a string matches a given regular expression pattern.
final class RegexSearchStrategy: SearchStrategy {

    enum InternalError: Error {

        case notAvailableToPredicates
    }

    /// An StringPredicateInputKind to search.
    let input: StringPredicateInputKind

    /// Initializes an instance of `RegexSearchStrategy`.
    /// - Parameter input: An StringPredicateInputKind to search.
    init(input: StringPredicateInputKind) {

        self.input = input
    }

    /// Evaluates whether a string matches the regular expression pattern.
    /// - Parameter string: The string to evaluate.
    /// - Returns: `true` if the string matches the regular expression pattern, `false` otherwise.
    func evaluate(string: String) throws -> Bool {

        switch self.input {

        case let .string(value):
            let regex = try NSRegularExpression(pattern: value,
                                                 options: [])
            let range = NSRange(location: 0,
                                length: string.utf16.count)
            return regex.firstMatch(in: string,
                                    options: [],
                                    range: range) != nil

        case .predicate:
            throw InternalError.notAvailableToPredicates
        }
    }
}

