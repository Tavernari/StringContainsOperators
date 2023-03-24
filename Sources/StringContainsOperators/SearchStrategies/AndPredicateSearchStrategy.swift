//
//  AndPredicateSearchStrategy.swift
//  
//
//  Created by Victor C Tavernari on 23/03/2023.
//

import Foundation

/// `AndPredicateSearchStrategy` is a type of `SearchStrategy` that searches for a `String` and a `StringPredicate` with an "AND" condition.
final class AndPredicateSearchStrategy: SearchStrategy {

    /// The string to be searched.
    let value: String

    /// The `StringPredicate` to be searched.
    let predicate: StringPredicate

    /// Initializes a new instance of `AndPredicateSearchStrategy`.
    ///
    /// - Parameters:
    ///   - value: The string to be searched.
    ///   - predicate: The `StringPredicate` to be searched.
    init(value: String, predicate: StringPredicate) {

        self.value = value
        self.predicate = predicate
    }

    /// Evaluates if a given string contains both the string `value` and the `StringPredicate` `predicate`.
    ///
    /// - Parameter string: The string to be evaluated.
    /// - Returns: `true` if the string contains both the string `value` and the `StringPredicate` `predicate`, `false` otherwise.
    func evaluate(string: String) -> Bool {

        return string.contains(self.predicate) && string.contains(self.value)
    }
}
