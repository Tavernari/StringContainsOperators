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
    func contains(_ predicate: StringPredicate) -> Bool {

        switch predicate {

        case let .base(predicate):
            return self.contains(predicate)

        case let .or(strings):
            return strings.contains(where: self.contains)

        case let .orPredicates(value, predicate):
            return self.contains(predicate) || self.contains(.or([value]))

        case let .and(strings):
            return strings.allSatisfy(self.contains)

        case let .andPredicates(value, predicate):
            return self.contains(predicate) && self.contains(.and([value]))
        }
    }
}


