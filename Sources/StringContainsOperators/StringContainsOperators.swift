import Foundation

infix operator || : LogicalDisjunctionPrecedence
infix operator && : LogicalConjunctionPrecedence
prefix operator ~

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
}

/// Returns a `StringPredicate` that performs a logical OR operation between two strings.
public func || (lhs: String, rhs: String) -> StringPredicate {

    return .or([lhs, rhs])
}

/// Returns a `StringPredicate` that performs a logical OR operation between a string and a `StringPredicate`.
public func || (lhs: String, rhs: StringPredicate) -> StringPredicate {

    return .orPredicates(lhs, rhs)
}

/// Returns a `StringPredicate` that performs a logical OR operation between a `StringPredicate` and a string.
public func || (lhs: StringPredicate, rhs: String) -> StringPredicate {

    return .orPredicates(rhs, lhs)
}

/// Returns a `StringPredicate` that performs a logical OR operation between two `StringPredicate`s.
public func || (lhs: StringPredicate, rhs: StringPredicate) -> StringPredicate {

    return .orOnlyPredicates([rhs, lhs])
}

/// Returns a `StringPredicate` that performs a logical AND operation between two strings.
public func && (lhs: String, rhs: String) -> StringPredicate {

    return .and([lhs, rhs])
}

/// Returns a `StringPredicate` that performs a logical AND operation between a string and a `StringPredicate`.
public func && (lhs: String, rhs: StringPredicate) -> StringPredicate {

    return .andPredicates(lhs, rhs)
}

/// Returns a `StringPredicate` that performs a logical AND operation between a `StringPredicate` and a string.
public func && (lhs: StringPredicate, rhs: String) -> StringPredicate {

    return .andPredicates(rhs, lhs)
}

/// Returns a `StringPredicate` that performs a logical AND operation between two `StringPredicate`s.
public func && (lhs: StringPredicate, rhs: StringPredicate) -> StringPredicate {

    return .andOnlyPredicates([rhs, lhs])
}

/// Returns a `StringPredicate` that performs a case-insensitive and diacritic-insensitive search for a given string.
public prefix func ~ (value: String) -> StringPredicate {

    return .diacriticAndCaseInsensitive(value)
}

public extension String {

    /// Returns a Boolean value indicating whether the string contains the given `StringPredicate`.
    ///
    /// - Parameter predicate: The `StringPredicate` to search for.
    /// - Returns: `true` if the string contains the `StringPredicate`, `false` otherwise.
    func contains(_ predicate: StringPredicate) -> Bool {

        switch predicate {

        case let .or(strings):
            return strings.contains(where: self.contains)

        case let .orPredicates(value, predicate):
            return self.contains(predicate) || self.contains(.or([value]))

        case let .orOnlyPredicates(predicates):
            return predicates.contains(where: self.contains)

        case let .and(strings):
            return strings.allSatisfy(self.contains)

        case let .andPredicates(value, predicate):
            return self.contains(predicate) && self.contains(.and([value]))

        case let .andOnlyPredicates(predicates):
            return predicates.allSatisfy(self.contains)

        case let .diacriticAndCaseInsensitive(value):

            return self.removeDiacriticsAndCase()
                .lowercased()
                .contains(value
                    .removeDiacriticsAndCase()
                    .lowercased())
        }
    }

    private func removeDiacriticsAndCase() -> String {

        return folding(options: .diacriticInsensitive,
                       locale: Locale.current)
    }
}
