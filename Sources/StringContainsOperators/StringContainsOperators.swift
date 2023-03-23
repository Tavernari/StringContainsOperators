import Foundation

infix operator || : LogicalDisjunctionPrecedence
infix operator && : LogicalConjunctionPrecedence
prefix operator ~

public indirect enum StringPredicate {
    case base(StringPredicate)
    case or([String])
    case orPredicates(String, StringPredicate)
    case orOnlyPredicates([StringPredicate])
    case and([String])
    case andPredicates(String, StringPredicate)
    case andOnlyPredicates([StringPredicate])
    case diacriticAndCaseInsensitive(String)
}

public func || (lhs: String, rhs: String) -> StringPredicate {

    return .base(.or([lhs, rhs]))
}

public func || (lhs: String, rhs: StringPredicate) -> StringPredicate {

    return .orPredicates(lhs, rhs)
}

public func || (lhs: StringPredicate, rhs: String) -> StringPredicate {

    return .orPredicates(rhs, lhs)
}

public func || (lhs: StringPredicate, rhs: StringPredicate) -> StringPredicate {

    return .orOnlyPredicates([rhs, lhs])
}

public func && (lhs: String, rhs: String) -> StringPredicate {

    return .base(.and([lhs, rhs]))
}

public func && (lhs: String, rhs: StringPredicate) -> StringPredicate {

    return .andPredicates(lhs, rhs)
}

public func && (lhs: StringPredicate, rhs: String) -> StringPredicate {

    return .andPredicates(rhs, lhs)
}

public func && (lhs: StringPredicate, rhs: StringPredicate) -> StringPredicate {

    return .andOnlyPredicates([rhs, lhs])
}

public prefix func ~ (value: String) -> StringPredicate {

    return .diacriticAndCaseInsensitive(value)
}

public extension String {
    func contains(_ predicate: StringPredicate) -> Bool {

        switch predicate {

        case let .base(value):
            return self.contains(value)

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
