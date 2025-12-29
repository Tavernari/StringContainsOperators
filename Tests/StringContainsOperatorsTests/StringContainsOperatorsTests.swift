//
//  StringContainsOperatorsTests.swift
//
//
//  Created by Victor C Tavernari on 23/03/2023.
//
import XCTest
@testable import StringContainsOperators

final class StringContainsOperatorsTests: XCTestCase {

    func testBaseStringPredicate() throws {

        let predicate = "Hello" || "World"
        XCTAssertTrue(try "Hello".contains(predicate))
        XCTAssertTrue(try "World".contains(predicate))
        XCTAssertFalse(try "Goodbye".contains(predicate))
    }

    func testOrStringPredicate() throws {

        let predicate = "Hello" || "World" || "Goodbye"
        XCTAssertTrue(try "Hello".contains(predicate))
        XCTAssertTrue(try "World".contains(predicate))
        XCTAssertTrue(try "Goodbye".contains(predicate))
        XCTAssertFalse(try "Goodnight".contains(predicate))
    }

    func testOrPredicates() throws {

        let predicate = "Hello" || ("W" && "o" && "r" && "l" && "d")
        XCTAssertTrue(try "Hello".contains(predicate))
        XCTAssertTrue(try "World".contains(predicate))
        XCTAssertFalse(try "Goodbye".contains(predicate))
        XCTAssertFalse(try "Hey".contains(predicate))
    }

    func testAndStringPredicate() throws {

        let predicate = "Hello" && "World"
        XCTAssertTrue(try "HelloWorld".contains(predicate))
        XCTAssertFalse(try "Hello".contains(predicate))
        XCTAssertFalse(try "World".contains(predicate))
        XCTAssertFalse(try "Goodbye".contains(predicate))
    }

    func testAndStringPredicateInsentitive() throws {

        let predicate = ~"Hello" && ~"World" && "Apple"
        XCTAssertTrue(try "HeLLoWórld Apple".contains(predicate))
        XCTAssertTrue(try "HelloWORLDApple".contains(predicate))
        XCTAssertTrue(try "HÉLLoWorlD  Apple".contains(predicate))
        XCTAssertFalse(try "ApplEGoodbyeWorld".contains(predicate))
    }
   
    func testAndPredicates() throws {

        let predicate = "H" && ("e" || "i") && "llo"
        XCTAssertTrue(try "Hello".contains(predicate))
        XCTAssertTrue(try "Hillo".contains(predicate))
        XCTAssertFalse(try "Hallo".contains(predicate))
        XCTAssertFalse(try "Hiyo".contains(predicate))
    }

    func testIndirectStringPredicate() throws {

        let predicate = ("Hello" || "World") && "!"
        XCTAssertTrue(try "Hello!".contains(predicate))
        XCTAssertTrue(try "World!".contains(predicate))
        XCTAssertFalse(try "Hello".contains(predicate))
    }

    func testNestedStringPredicate() throws {

        let predicate = "Hello" || ("W" && ("o" || "i") && "r" && "l" && "d")
        XCTAssertTrue(try "Hello".contains(predicate))
        XCTAssertTrue(try "World".contains(predicate))
        XCTAssertTrue(try "Wirld".contains(predicate))
        XCTAssertFalse(try "Goodbye".contains(predicate))
    }

    func testDiacriticInsensitiveLowercase() throws {

        let predicate = ~"héllo" || ~"wórld"
        XCTAssertTrue(try "hello".contains(predicate))
        XCTAssertTrue(try "world".contains(predicate))
        XCTAssertFalse(try "goodbye".contains(predicate))
    }

    func testDiacriticInsensitiveUppercase() throws {

        let predicate = ~"héllo" || ~"wórld"
        XCTAssertTrue(try "HELLO".contains(predicate))
        XCTAssertTrue(try "WORLD".contains(predicate))
        XCTAssertFalse(try "GOODBYE".contains(predicate))
    }

    func testDiacriticInsensitiveMixedcase() throws {

        let predicate = ~"héllo" || ~"wórld"
        XCTAssertTrue(try "Hello".contains(predicate))
        XCTAssertTrue(try "World".contains(predicate))
        XCTAssertTrue(try "HeLLo".contains(predicate))
        XCTAssertTrue(try "wORLD".contains(predicate))
        XCTAssertFalse(try "Goodbye".contains(predicate))
    }

    func testDiacriticInsensitiveMixedcaseWithOtherChars() throws {

        let predicate = ~"héllo" || ~"wórld"
        XCTAssertTrue(try "Hello!".contains(predicate))
        XCTAssertTrue(try "World?".contains(predicate))
        XCTAssertTrue(try "HeLLo.".contains(predicate))
        XCTAssertTrue(try "wORLD-".contains(predicate))
        XCTAssertFalse(try "Goodbye".contains(predicate))
    }

    func testContainsWithRegexp() throws {

        let string = "This is a test string"

        let predicate = "test" && "string" && =~"is.a"

        XCTAssertTrue(try string.contains(predicate))

        let invalidString = "This is not a valid string"
        XCTAssertFalse(try invalidString.contains(predicate))
    }

    func testWithInvalidRegexp() throws {

        let string = "This is a test string"

        XCTAssertThrowsError(try string.contains(=~"^*$(dis.a"))
    }

    func testNegatablePredicate() throws {

        let text = "Hello my little friend"

        XCTAssertTrue(try text.contains(!"fiance"))
        XCTAssertFalse(try text.contains(!"my"))
        XCTAssertTrue(try text.contains(!("enemy" && "little")))
        XCTAssertFalse(try text.contains(!("friend" && "little")))
        XCTAssertTrue(try text.contains(!("enemy" || "big")))
        XCTAssertFalse(try text.contains(!("friend" || "big")))
    }

    func testPrefixOperator() throws {
        let text = "My name is Victor"

        XCTAssertTrue(try text.contains(^"My"))
        XCTAssertTrue(try text.contains(^"My name"))
        XCTAssertTrue(try text.contains(^"My name is Victor"))
        XCTAssertFalse(try text.contains(^"name"))
        XCTAssertFalse(try text.contains(^"Victor"))
        XCTAssertFalse(try text.contains(^"my"))  // case sensitive
    }

    func testPrefixOperatorWithEmptyString() throws {
        let text = "Hello"

        XCTAssertTrue(try text.contains(^""))
        XCTAssertTrue(try text.contains(^"H"))
        XCTAssertTrue(try text.contains(^"He"))
    }

    func testPrefixOperatorCombinedWithOr() throws {
        let text = "The quick brown fox"

        XCTAssertTrue(try text.contains(^"The" || ^"A"))
        XCTAssertTrue(try text.contains(^"A" || ^"The"))
        XCTAssertFalse(try text.contains(^"quick" || ^"slow"))
    }

    func testPrefixOperatorCombinedWithAnd() throws {
        let text = "Hello World"

        XCTAssertTrue(try text.contains(^"Hello" && "World"))
        XCTAssertTrue(try text.contains(^"H" && "World"))
        XCTAssertFalse(try text.contains(^"Hello" && "Moon"))
    }

    func testPrefixOperatorWithDiacriticInsensitivity() throws {
        let text = "Héllo World"

        // Without ~, should be case and diacritic sensitive
        XCTAssertFalse(try text.contains(^"Hello"))
        
        // With ~ operator (but prefix doesn't support nested predicates, so this tests the basic case)
        // Actually, ^~ would need to be: ~"Héllo" has prefix ~"Héllo"
        // For now, let's test basic prefix with diacritics
        XCTAssertTrue(try text.contains(^"Héllo"))
        XCTAssertTrue(try text.contains(^"Hé"))
    }

    func testPrefixOperatorInComplexPredicate() throws {
        let text = "The quick brown fox jumps"

        // Complex: starts with "The" AND contains "jumps"
        let predicate1 = ^"The" && "jumps"
        XCTAssertTrue(try text.contains(predicate1))

        // Complex: starts with "The" OR starts with "A"
        let predicate2 = ^"The" || ^"A"
        XCTAssertTrue(try text.contains(predicate2))

        // Complex: NOT starts with "Quick" AND contains "fox"
        let predicate3 = !(^"Quick") && "fox"
        XCTAssertTrue(try text.contains(predicate3))
    }

    func testPrefixOperatorWithCombinedOperators() throws {
        let text = "My name is Victor"

        // Prefix with OR
        XCTAssertTrue(try text.contains(^"My" || ^"Your"))
        XCTAssertFalse(try text.contains(^"Your" || ^"Their"))

        // Prefix with AND
        XCTAssertTrue(try text.contains(^"My" && "Victor"))
        XCTAssertFalse(try text.contains(^"My" && "George"))

        // Negated prefix
        XCTAssertTrue(try text.contains(!(^"Your")))
        XCTAssertFalse(try text.contains(!(^"My")))

        // Combine everything
        let complex = (^"My" && "Victor") || ^"Your"
        XCTAssertTrue(try text.contains(complex))
    }
}
