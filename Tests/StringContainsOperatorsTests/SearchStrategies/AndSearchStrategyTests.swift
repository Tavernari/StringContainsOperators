//
//  AndSearchStrategyTests.swift
//  
//
//  Created by Victor C Tavernari on 25/03/2023.
//

import XCTest
@testable import StringContainsOperators

final class AndSearchStrategyTests: XCTestCase {

    let validString = "Hello blue planet"
    let invalidString = "---"

    func testStringInputs() throws {

        let strategy = AndSearchStrategy(input: [
            .string("blue"),
            .string("planet"),
            .string("Hello")
        ])

        XCTAssertTrue(try strategy.evaluate(string: self.validString))
        XCTAssertFalse(try strategy.evaluate(string: self.invalidString))
    }

    func testPredicateInputs() throws {

        let strategy = AndSearchStrategy(input: [
            .predicate(.and([.string("blue"),
                             .string("planet")])),
            .predicate(.and([.string("planet"),
                             .string("Hello")]))
        ])

        XCTAssertTrue(try strategy.evaluate(string: self.validString))
        XCTAssertFalse(try strategy.evaluate(string: self.invalidString))
    }

    func testPredicateAndStringInputs() throws {

        let strategy = AndSearchStrategy(input: [
            .predicate(.and([.string("blue"),
                            .string("planet")])),
            .string("Hello"),
            .string("planet")
        ])

        XCTAssertTrue(try strategy.evaluate(string: self.validString))
        XCTAssertFalse(try strategy.evaluate(string: self.invalidString))
    }
}
