//
//  OrPredicateSearchStrategy.swift
//  
//
//  Created by Victor C Tavernari on 23/03/2023.
//

import Foundation


/// An OrPredicateSearchStrategy is a SearchStrategy that searches for the occurrence of a given string or a given StringPredicate.
final class OrPredicateSearchStrategy: SearchStrategy {

    /// The string to search for.
    let value: String

    /// The predicate to search for.
    let predicate: StringPredicate

    /// Creates a new `OrPredicateSearchStrategy` instance with the given string and predicate.
    ///
    /// - Parameters:
    ///   - value: The string to search for.
    ///   - predicate: The predicate to search for.
    init(value: String, predicate: StringPredicate) {

        self.value = value
        self.predicate = predicate
    }

    /// Evaluates whether the given string contains either the string or the predicate that this strategy is looking for.
    ///
    /// - Parameter string: The string to evaluate.
    /// - Returns: `true` if the string contains either the string or the predicate that this strategy is looking for, `false` otherwise.
    func evaluate(string: String) -> Bool {

        return string.contains(self.predicate) || string.contains(self.value)
    }
}
