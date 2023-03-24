//
//  NegatableValueSearchStrategy.swift
//  
//
//  Created by Victor C Tavernari on 24/03/2023.
//

import Foundation

/// A search strategy that negates the presence of a given value in a string.
final class NegatableValueSearchStrategy: SearchStrategy {

    let value: String

    init(value: String) {

        self.value = value
    }

    /// Evaluates the given string with the negated value search strategy.
    ///
    /// - Parameter string: The string to be evaluated.
    /// - Returns: `true` if the given string does not contain the value, `false` otherwise.
    func evaluate(string: String) -> Bool {

        return !string.contains(self.value)
    }
}

