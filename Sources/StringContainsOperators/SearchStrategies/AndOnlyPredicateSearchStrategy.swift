//
//  AndOnlyPredicateSearchStrategy.swift
//
//
//  Created by Victor C Tavernari on 23/03/2023.
//

import Foundation

/// `AndOnlyPredicateSearchStrategy` is a type of `SearchStrategy` that searches for multiple `StringPredicate`s with an "AND" condition.
final class AndOnlyPredicateSearchStrategy: SearchStrategy {

    /// The list of `StringPredicate`s to be searched.
    let predicates: [StringPredicate]

    /// Initializes a new instance of `AndOnlyPredicateSearchStrategy`.
    ///
    /// - Parameter predicates: The list of `StringPredicate`s to be searched.
    init(predicates: [StringPredicate]) {

        self.predicates = predicates
    }

    /// Evaluates if a given string contains all of the `StringPredicate`s in the `predicates` array.
    ///
    /// - Parameter string: The string to be evaluated.
    /// - Returns: `true` if the string contains all of the `StringPredicate`s in the `predicates` array, `false` otherwise.
    func evaluate(string: String) -> Bool {

        return predicates.allSatisfy(string.contains)
    }
}
