//
//  RegexSearchStrategy.swift
//  
//
//  Created by Victor C Tavernari on 24/03/2023.
//

import Foundation

/// A search strategy that evaluates whether a string matches a given regular expression pattern.
final class RegexSearchStrategy: SearchStrategy {

    /// The regular expression pattern to match.
    let regex: NSRegularExpression?

    /// Creates a new instance of `RegexSearchStrategy` with the given regular expression pattern.
    /// - Parameter pattern: The regular expression pattern to match.
    init(pattern: String) {

        self.regex = try? NSRegularExpression(pattern: pattern,
                                             options: [])
    }

    /// Evaluates whether a string matches the regular expression pattern.
    /// - Parameter string: The string to evaluate.
    /// - Returns: `true` if the string matches the regular expression pattern, `false` otherwise.
    func evaluate(string: String) -> Bool {

        let range = NSRange(location: 0, length: string.utf16.count)
        return self.regex?.firstMatch(in: string, options: [], range: range) != nil
    }
}

