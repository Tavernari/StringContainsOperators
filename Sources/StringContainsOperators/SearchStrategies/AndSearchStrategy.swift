//
//  AndSearchStrategy.swift
//  
//
//  Created by Victor C Tavernari on 23/03/2023.
//

import Foundation

/// `AndSearchStrategy` is a type of `SearchStrategy` that searches for multiple `String`s with an "AND" condition.
final class AndSearchStrategy: SearchStrategy {

    /// The list of strings to be searched.
    let strings: [String]

    /// Initializes a new instance of `AndSearchStrategy`.
    ///
    /// - Parameter strings: The list of strings to be searched.
    init(strings: [String]) {

        self.strings = strings
    }

    /// Evaluates if a given string contains all of the `String`s in the `strings` array.
    ///
    /// - Parameter string: The string to be evaluated.
    /// - Returns: `true` if the string contains all of the `String`s in the `strings` array, `false` otherwise.
    func evaluate(string: String) -> Bool {

        return strings.allSatisfy(string.contains)
    }
}
