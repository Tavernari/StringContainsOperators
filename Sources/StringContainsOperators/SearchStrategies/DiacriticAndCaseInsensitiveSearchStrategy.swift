//
//  DiacriticAndCaseInsensitiveSearchStrategy.swift
//  
//
//  Created by Victor C Tavernari on 23/03/2023.
//

import Foundation

/// `DiacriticAndCaseInsensitiveSearchStrategy` is a type of `SearchStrategy` that searches for a `String` case-insensitively and without diacritics.
final class DiacriticAndCaseInsensitiveSearchStrategy: SearchStrategy {

    /// The string to be searched without diacritics and case-insensitively.
    let value: String

    /// Initializes a new instance of `DiacriticAndCaseInsensitiveSearchStrategy`.
    ///
    /// - Parameter value: The string to be searched.
    init(value: String) {

        self.value = value.removeDiacriticsAndCase().lowercased()
    }

    /// Evaluates if a given string contains the `value` string without diacritics and case-insensitively.
    ///
    /// - Parameter string: The string to be evaluated.
    /// - Returns: `true` if the string contains the `value` string without diacritics and case-insensitively, `false` otherwise.
    func evaluate(string: String) -> Bool {

        return string
            .removeDiacriticsAndCase()
            .lowercased()
            .contains(self.value)
    }
}
