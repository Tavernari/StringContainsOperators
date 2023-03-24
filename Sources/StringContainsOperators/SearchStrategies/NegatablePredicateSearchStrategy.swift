//
//  NegatablePredicateSearchStrategy.swift
//  
//
//  Created by Victor C Tavernari on 24/03/2023.
//

import Foundation

/// A search strategy that negates the result of another search strategy.
final class NegatablePredicateSearchStrategy: SearchStrategy {

    let searchStrategy: SearchStrategy

    init(searchStrategy: SearchStrategy) {

        self.searchStrategy = searchStrategy
    }

    /// Evaluates the given string with the negated search strategy.
    ///
    /// - Parameter string: The string to be evaluated.
    /// - Returns: `true` if the given string does not match the original search strategy, `false` otherwise.
    func evaluate(string: String) -> Bool {

        return !self.searchStrategy.evaluate(string: string)
    }
}

