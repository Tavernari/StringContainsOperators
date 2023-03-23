//
//  StringContainsOperatorsTests.swift
//
//
//  Created by Victor C Tavernari on 23/03/2023.
//
import XCTest
@testable import StringContainsOperators

final class StringContainsOperatorsTests: XCTestCase {

    func testBaseStringPredicate() {
           let predicate = "Hello" || "World"
           XCTAssertTrue("Hello".contains(predicate))
           XCTAssertTrue("World".contains(predicate))
           XCTAssertFalse("Goodbye".contains(predicate))
    }

    func testOrStringPredicate() {
       let predicate = "Hello" || "World" || "Goodbye"
       XCTAssertTrue("Hello".contains(predicate))
       XCTAssertTrue("World".contains(predicate))
       XCTAssertTrue("Goodbye".contains(predicate))
       XCTAssertFalse("Goodnight".contains(predicate))
    }

    func testOrPredicates() {
       let predicate = "Hello" || ("W" && "o" && "r" && "l" && "d")
       XCTAssertTrue("Hello".contains(predicate))
       XCTAssertTrue("World".contains(predicate))
       XCTAssertFalse("Goodbye".contains(predicate))
       XCTAssertFalse("Hey".contains(predicate))
    }

    func testAndStringPredicate() {
       let predicate = "Hello" && "World"
       XCTAssertTrue("HelloWorld".contains(predicate))
       XCTAssertFalse("Hello".contains(predicate))
       XCTAssertFalse("World".contains(predicate))
       XCTAssertFalse("Goodbye".contains(predicate))
    }

    func testAndStringPredicateInsentitive() {
        let predicate = ~"Hello" && ~"World" && "Apple"
        XCTAssertTrue("HeLLoWórld Apple".contains(predicate))
        XCTAssertTrue("HelloWORLDApple".contains(predicate))
        XCTAssertTrue("HÉLLoWorlD  Apple".contains(predicate))
        XCTAssertFalse("ApplEGoodbyeWorld".contains(predicate))
    }
   
    func testAndPredicates() {
       let predicate = "H" && ("e" || "i") && "llo"
       XCTAssertTrue("Hello".contains(predicate))
       XCTAssertTrue("Hillo".contains(predicate))
       XCTAssertFalse("Hallo".contains(predicate))
       XCTAssertFalse("Hiyo".contains(predicate))
    }

    func testIndirectStringPredicate() {
       let predicate = ("Hello" || "World") && "!"
       XCTAssertTrue("Hello!".contains(predicate))
       XCTAssertTrue("World!".contains(predicate))
       XCTAssertFalse("Hello".contains(predicate))
    }

    func testNestedStringPredicate() {
       let predicate = "Hello" || ("W" && ("o" || "i") && "r" && "l" && "d")
       XCTAssertTrue("Hello".contains(predicate))
       XCTAssertTrue("World".contains(predicate))
       XCTAssertTrue("Wirld".contains(predicate))
       XCTAssertFalse("Goodbye".contains(predicate))
    }

    func testDiacriticInsensitiveLowercase() {
        let predicate = ~"héllo" || ~"wórld"
        XCTAssertTrue("hello".contains(predicate))
        XCTAssertTrue("world".contains(predicate))
        XCTAssertFalse("goodbye".contains(predicate))
    }

    func testDiacriticInsensitiveUppercase() {
        let predicate = ~"héllo" || ~"wórld"
        XCTAssertTrue("HELLO".contains(predicate))
        XCTAssertTrue("WORLD".contains(predicate))
        XCTAssertFalse("GOODBYE".contains(predicate))
    }

    func testDiacriticInsensitiveMixedcase() {
        let predicate = ~"héllo" || ~"wórld"
        XCTAssertTrue("Hello".contains(predicate))
        XCTAssertTrue("World".contains(predicate))
        XCTAssertTrue("HeLLo".contains(predicate))
        XCTAssertTrue("wORLD".contains(predicate))
        XCTAssertFalse("Goodbye".contains(predicate))
    }

    func testDiacriticInsensitiveMixedcaseWithOtherChars() {
        let predicate = ~"héllo" || ~"wórld"
        XCTAssertTrue("Hello!".contains(predicate))
        XCTAssertTrue("World?".contains(predicate))
        XCTAssertTrue("HeLLo.".contains(predicate))
        XCTAssertTrue("wORLD-".contains(predicate))
        XCTAssertFalse("Goodbye".contains(predicate))
    }
}
