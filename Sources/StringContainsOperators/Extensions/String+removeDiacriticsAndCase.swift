//
//  String+removeDiacriticsAndCase.swift
//  
//
//  Created by Victor C Tavernari on 23/03/2023.
//

import Foundation

/// An extension of String that removes diacritics and lowercase the string.
extension String {

    /// Removes diacritics and lowercase the string.
    ///
    /// - Returns: The string with removed diacritics and lowercase.
    func removeDiacriticsAndCase() -> String {

        return folding(options: .diacriticInsensitive,
                       locale: Locale.current)
    }
}
