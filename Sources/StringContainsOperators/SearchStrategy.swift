//
//  SearchStrategy.swift
//  
//
//  Created by Victor C Tavernari on 23/03/2023.
//

import Foundation

/// A protocol that defines the behavior of a search strategy.
protocol SearchStrategy {

    /// Evaluates if a given string matches the search strategy.
    ///
    /// - Parameter string: The string to evaluate.
    /// - Returns: `true` if the string matches the search strategy, otherwise `false`.
    func evaluate(string: String) -> Bool
}
