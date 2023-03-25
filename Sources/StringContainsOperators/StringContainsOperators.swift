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


public enum StringPredicateInputKind {

    case string(String)
    case predicate(StringPredicate)
}

/// An enum representing a string search predicate.
public indirect enum StringPredicate {

    /// Represents a logical OR operation between multiple strings.
    case or([StringPredicateInputKind])

    /// Represents a logical AND operation between multiple strings.
    case and([StringPredicateInputKind])

    /// Represents a case-insensitive and diacritic-insensitive search for a given string.
    case diacriticAndCaseInsensitive(StringPredicateInputKind)

    /// Represents a regular expression pattern that can be used to match a string using NSRegularExpression.
    /// - Note: The String value should be a valid regular expression pattern.
    case regexp(StringPredicateInputKind)
    
    /// Represents a negatable search predicate for a given string.
    case negatable(StringPredicateInputKind)
}

/// Returns a `StringPredicate` that performs a logical OR operation between two strings.
/// - Parameters:
///   - lhs: The first string to be evaluated.
///   - rhs: The second string to be evaluated.
/// - Returns: A `StringPredicate` that performs a logical OR operation between two strings.
public func || (lhs: String, rhs: String) -> StringPredicate {

    return .or([.string(lhs), .string(rhs)])
}

/// Returns a `StringPredicate` that performs a logical OR operation between a string and a `StringPredicate`.
/// - Parameters:
///   - lhs: The string to be evaluated.
///   - rhs: The `StringPredicate` to be evaluated.
/// - Returns: A `StringPredicate` that performs a logical OR operation between a string and a `StringPredicate`.
public func || (lhs: String, rhs: StringPredicate) -> StringPredicate {

    return .or([.string(lhs), .predicate(rhs)])
}

/// Returns a `StringPredicate` that performs a logical OR operation between a `StringPredicate` and a string.
/// - Parameters:
///   - lhs: The `StringPredicate` to be evaluated.
///   - rhs: The string to be evaluated.
/// - Returns: A `StringPredicate` that performs a logical OR operation between a `StringPredicate` and a string.
public func || (lhs: StringPredicate, rhs: String) -> StringPredicate {

    return .or([.predicate(lhs), .string(rhs)])
}

/// Returns a `StringPredicate` that performs a logical OR operation between two `StringPredicate`s.
/// - Parameters:
///   - lhs: The first `StringPredicate` to be evaluated.
///   - rhs: The second `StringPredicate` to be evaluated.
/// - Returns: A `StringPredicate` that performs a logical OR operation between two `StringPredicate`s.
public func || (lhs: StringPredicate, rhs: StringPredicate) -> StringPredicate {

    return .or([.predicate(lhs), .predicate(rhs)])
}

/// Returns a `StringPredicate` that performs a logical AND operation between two strings.
/// - Parameters:
///   - lhs: The first string to be evaluated.
///   - rhs: The second string to be evaluated.
/// - Returns: A `StringPredicate` that performs a logical AND operation between two strings.
public func && (lhs: String, rhs: String) -> StringPredicate {

    return .and([.string(lhs), .string(rhs)])
}

/// Returns a `StringPredicate` that performs a logical AND operation between a string and a `StringPredicate`.
/// - Parameters:
///   - lhs: The string to be evaluated.
///   - rhs: The `StringPredicate` to be evaluated.
/// - Returns: A `StringPredicate` that performs a logical AND operation between a string and a `StringPredicate`.
public func && (lhs: String, rhs: StringPredicate) -> StringPredicate {

    return .and([.string(lhs), .predicate(rhs)])
}

/// Returns a `StringPredicate` that performs a logical AND operation between a `StringPredicate` and a string.
/// - Parameters:
///   - lhs: The `StringPredicate` to be evaluated.
///   - rhs: The string to be evaluated.
/// - Returns: A `StringPredicate` that performs a logical AND operation between a `StringPredicate` and a string.
public func && (lhs: StringPredicate, rhs: String) -> StringPredicate {

    return .and([.predicate(lhs), .string(rhs)])
}

/// Returns a `StringPredicate` that performs a logical AND operation between two `StringPredicate`s.
/// - Parameters:
///   - lhs: The first `StringPredicate` to be evaluated.
///   - rhs: The second `StringPredicate` to be evaluated.
/// - Returns: A `StringPredicate
public func && (lhs: StringPredicate, rhs: StringPredicate) -> StringPredicate {

    return .and([.predicate(lhs), .predicate(rhs)])
}

/// Returns a `StringPredicate` that performs a case-insensitive and diacritic-insensitive search for a given string.
///
/// - Parameter value: The value to be evaluated.
/// - Returns: A `StringPredicate` that performs a case-insensitive and diacritic-insensitive search for a given string.
public prefix func ~ (value: String) -> StringPredicate {

    return .diacriticAndCaseInsensitive(.string(value))
}

/// Returns a `StringPredicate` that performs a regular expression pattern that can be used to match a string using NSRegularExpression.
///
/// - Parameter pattern: The regular expression pattern as a string value.
/// - Returns: A `StringPredicate` that can be used to perform regular expression pattern matching.
public prefix func =~ (pattern: String) -> StringPredicate {

    return .regexp(.string(pattern))
}

/// Returns a `StringPredicate` that negates another `StringPredicate`.
///
/// - Parameter predicate: The predicate to be negated.
/// - Returns: A `StringPredicate` that represents the negation of the given predicate.
public prefix func ! (predicate: StringPredicate) -> StringPredicate {

    return .negatable(.predicate(predicate))
}

/// Returns a `StringPredicate` that negates a given value.
///
/// - Parameter value: The value to be negated.
/// - Returns: A `StringPredicate` that represents the negation of the given value.
public prefix func ! (value: String) -> StringPredicate {

    return .negatable(.string(value))
}

public extension String {

    /// Returns a Boolean value indicating whether the string contains the given `StringPredicate`.
    ///
    /// - Parameter predicate: The `StringPredicate` to search for.
    /// - Returns: `true` if the string contains the `StringPredicate`, `false` otherwise.
    func contains(_ predicate: StringPredicate) throws -> Bool {

        try SearchStrategyMaker
                .make(predicate: predicate)
                .evaluate(string: self)
    }
}
