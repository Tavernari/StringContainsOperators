//
//  File.swift
//  
//
//  Created by Victor C Tavernari on 23/03/2023.
//

import Foundation


/// `SearchStrategyMaker` is a factory that produces `SearchStrategy` objects based on a given `StringPredicate`.
enum SearchStrategyMaker {

    /// Creates an appropriate `SearchStrategy` based on the given `StringPredicate`.
    ///
    /// - Parameter predicate: The `StringPredicate` to base the `SearchStrategy` on.
    /// - Returns: The appropriate `SearchStrategy`.
    static func make(predicate: StringPredicate) -> SearchStrategy {

        switch predicate {

        case let .or(input):
            return OrSearchStrategy(input: input)

        case let .and(input):
            return AndSearchStrategy(input: input)

        case let .diacriticAndCaseInsensitive(input):
            return DiacriticAndCaseInsensitiveSearchStrategy(input: input)

        case let .regexp(input):
            return RegexSearchStrategy(input: input)

        case let .negatable(input):
            return NegatableSearchStrategy(input: input)
        }
    }
}
