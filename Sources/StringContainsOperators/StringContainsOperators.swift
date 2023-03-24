//
//  StringContainsOperators.swift
//
//
//  Created by Victor C Tavernari on 23/03/2023.
//
import Foundation

infix operator || : LogicalDisjunctionPrecedence
infix operator && : LogicalConjunctionPrecedence
prefix operator ~
prefix operator =~
prefix operator !

/// An enum representing a string search predicate.
public indirect enum StringPredicate {

    /// Represents a logical OR operation between multiple strings.
    case or([String])

    /// Represents a logical OR operation between a string and a `StringPredicate`.
    case orPredicates(String, StringPredicate)

    /// Represents a logical OR operation between multiple `StringPredicate`s.
    case orOnlyPredicates([StringPredicate])

    /// Represents a logical AND operation between multiple strings.
    case and([String])

    /// Represents a logical AND operation between a string and a `StringPredicate`.
    case andPredicates(String, StringPredicate)

    /// Represents a logical AND operation between multiple `StringPredicate`s.
    case andOnlyPredicates([StringPredicate])

    /// Represents a case-insensitive and diacritic-insensitive search for a given string.
    case diacriticAndCaseInsensitive(String)

    /// Represents a regular expression pattern that can be used to match a string using NSRegularExpression.
    /// - Note: The String value should be a valid regular expression pattern.
    case regexp(String)
    
    /// Represents a negatable search predicate for a given string.
    case negatable(String)

    /// Represents a negatable search predicate for a given `StringPredicate`.
    case negatablePredicate(StringPredicate)
}

/// Returns a `StringPredicate` that performs a logical OR operation between two strings.
/// - Parameters:
///   - lhs: The first string to be evaluated.
///   - rhs: The second string to be evaluated.
/// - Returns: A `StringPredicate` that performs a logical OR operation between two strings.
public func || (lhs: String, rhs: String) -> StringPredicate {

    return .or([lhs, rhs])
}

/// Returns a `StringPredicate` that performs a logical OR operation between a string and a `StringPredicate`.
/// - Parameters:
///   - lhs: The string to be evaluated.
///   - rhs: The `StringPredicate` to be evaluated.
/// - Returns: A `StringPredicate` that performs a logical OR operation between a string and a `StringPredicate`.
public func || (lhs: String, rhs: StringPredicate) -> StringPredicate {

    return .orPredicates(lhs, rhs)
}

/// Returns a `StringPredicate` that performs a logical OR operation between a `StringPredicate` and a string.
/// - Parameters:
///   - lhs: The `StringPredicate` to be evaluated.
///   - rhs: The string to be evaluated.
/// - Returns: A `StringPredicate` that performs a logical OR operation between a `StringPredicate` and a string.
public func || (lhs: StringPredicate, rhs: String) -> StringPredicate {

    return .orPredicates(rhs, lhs)
}

/// Returns a `StringPredicate` that performs a logical OR operation between two `StringPredicate`s.
/// - Parameters:
///   - lhs: The first `StringPredicate` to be evaluated.
///   - rhs: The second `StringPredicate` to be evaluated.
/// - Returns: A `StringPredicate` that performs a logical OR operation between two `StringPredicate`s.
public func || (lhs: StringPredicate, rhs: StringPredicate) -> StringPredicate {

    return .orOnlyPredicates([rhs, lhs])
}

/// Returns a `StringPredicate` that performs a logical AND operation between two strings.
/// - Parameters:
///   - lhs: The first string to be evaluated.
///   - rhs: The second string to be evaluated.
/// - Returns: A `StringPredicate` that performs a logical AND operation between two strings.
public func && (lhs: String, rhs: String) -> StringPredicate {

    return .and([lhs, rhs])
}

/// Returns a `StringPredicate` that performs a logical AND operation between a string and a `StringPredicate`.
/// - Parameters:
///   - lhs: The string to be evaluated.
///   - rhs: The `StringPredicate` to be evaluated.
/// - Returns: A `StringPredicate` that performs a logical AND operation between a string and a `StringPredicate`.
public func && (lhs: String, rhs: StringPredicate) -> StringPredicate {

    return .andPredicates(lhs, rhs)
}

/// Returns a `StringPredicate` that performs a logical AND operation between a `StringPredicate` and a string.
/// - Parameters:
///   - lhs: The `StringPredicate` to be evaluated.
///   - rhs: The string to be evaluated.
/// - Returns: A `StringPredicate` that performs a logical AND operation between a `StringPredicate` and a string.
public func && (lhs: StringPredicate, rhs: String) -> StringPredicate {

    return .andPredicates(rhs, lhs)
}

/// Returns a `StringPredicate` that performs a logical AND operation between two `StringPredicate`s.
/// - Parameters:
///   - lhs: The first `StringPredicate` to be evaluated.
///   - rhs: The second `StringPredicate` to be evaluated.
/// - Returns: A `StringPredicate
public func && (lhs: StringPredicate, rhs: StringPredicate) -> StringPredicate {

    return .andOnlyPredicates([rhs, lhs])
}

/// Returns a `StringPredicate` that performs a case-insensitive and diacritic-insensitive search for a given string.
///
/// - Parameter value: The value to be evaluated.
/// - Returns: A `StringPredicate` that performs a case-insensitive and diacritic-insensitive search for a given string.
public prefix func ~ (value: String) -> StringPredicate {

    return .diacriticAndCaseInsensitive(value)
}

/// Returns a `StringPredicate` that performs a regular expression pattern that can be used to match a string using NSRegularExpression.
///
/// - Parameter value: The regular expression pattern as a string value.
/// - Returns: A `StringPredicate` that can be used to perform regular expression pattern matching.
public prefix func =~ (value: String) -> StringPredicate {

    return .regexp(value)
}


/// Returns a `StringPredicate` that negates another `StringPredicate`.
///
/// - Parameter predicate: The predicate to be negated.
/// - Returns: A `StringPredicate` that represents the negation of the given predicate.
public prefix func ! (predicate: StringPredicate) -> StringPredicate {

    return .negatablePredicate(predicate)
}

/// Returns a `StringPredicate` that negates a given value.
///
/// - Parameter value: The value to be negated.
/// - Returns: A `StringPredicate` that represents the negation of the given value.
public prefix func ! (value: String) -> StringPredicate {

    return .negatable(value)
}

public extension String {

    /// Returns a Boolean value indicating whether the string contains the given `StringPredicate`.
    ///
    /// - Parameter predicate: The `StringPredicate` to search for.
    /// - Returns: `true` if the string contains the `StringPredicate`, `false` otherwise.
    func contains(_ predicate: StringPredicate) -> Bool {

        SearchStrategyMaker
            .make(predicate: predicate)
            .evaluate(string: self)
    }
}
