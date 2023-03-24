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

        case let .or(strings):
            return OrSearchStrategy(strings: strings)

        case let .orPredicates(value, predicate):
            return OrPredicateSearchStrategy(value: value, predicate: predicate)

        case let .orOnlyPredicates(predicates):
            return OrOnlyPredicateSearchStrategy(predicates: predicates)

        case let .and(strings):
            return AndSearchStrategy(strings: strings)

        case let .andPredicates(value, predicate):
            return AndPredicateSearchStrategy(value: value, predicate: predicate)

        case let .andOnlyPredicates(predicates):
            return AndOnlyPredicateSearchStrategy(predicates: predicates)

        case let .diacriticAndCaseInsensitive(value):
            return DiacriticAndCaseInsensitiveSearchStrategy(value: value)

        case let .negatable(value):
            return NegatableValueSearchStrategy(value: value)

        case let .negatablePredicate(predicate):
            return NegatablePredicateSearchStrategy(searchStrategy: self.make(predicate: predicate))
        }
    }
}
