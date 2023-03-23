import Foundation

infix operator || : LogicalDisjunctionPrecedence
infix operator && : LogicalConjunctionPrecedence

public indirect enum StringPredicate {
    case base(StringPredicate)
    case or([String])
    case orPredicates(String, StringPredicate)
    case and([String])
    case andPredicates(String, StringPredicate)
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

public func && (lhs: String, rhs: String) -> StringPredicate {

    return .base(.and([lhs, rhs]))
}

public func && (lhs: String, rhs: StringPredicate) -> StringPredicate {

    return .andPredicates(lhs, rhs)
}

public func && (lhs: StringPredicate, rhs: String) -> StringPredicate {

    return .andPredicates(rhs, lhs)
}

public extension String {
    func contains(_ predicate: StringPredicate, diacriticAndCaseInsensitive: Bool = false) -> Bool {

        switch predicate {

        case let .base(predicate):
            return self.contains(predicate)

        case let .or(strings):
            if diacriticAndCaseInsensitive {
                return strings.contains(where: self.contains)
            } else {
                return strings.contains(where: { self.containsIgnoringDiacriticsAndCase($0) })
            }

        case let .orPredicates(value, predicate):
            let str = diacriticAndCaseInsensitive ? value : value.removeDiacriticsAndCase()
            return self.contains(predicate, diacriticAndCaseInsensitive: diacriticAndCaseInsensitive) || self.contains(.or([str]), diacriticAndCaseInsensitive: diacriticAndCaseInsensitive)

        case let .and(strings):
            if diacriticAndCaseInsensitive {
                return strings.allSatisfy(self.contains)
            } else {
                return strings.allSatisfy({ self.containsIgnoringDiacriticsAndCase($0) })
            }

        case let .andPredicates(value, predicate):
            let str = diacriticAndCaseInsensitive ? value : value.removeDiacriticsAndCase()
            return self.contains(predicate, diacriticAndCaseInsensitive: diacriticAndCaseInsensitive) && self.contains(.and([str]), diacriticAndCaseInsensitive: diacriticAndCaseInsensitive)
        }
    }

    func containsIgnoringDiacriticsAndCase(_ other: String) -> Bool {
        let lhs = self.removeDiacriticsAndCase()
        let rhs = other.removeDiacriticsAndCase()
        return lhs.contains(rhs)
    }

    private func removeDiacriticsAndCase() -> String {
        return folding(options: .diacriticInsensitive, locale: Locale.current).lowercased()
    }
}
