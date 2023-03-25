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
}
