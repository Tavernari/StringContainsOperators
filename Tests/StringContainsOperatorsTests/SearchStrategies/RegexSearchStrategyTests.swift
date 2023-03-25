//
//  RegexSearchStrategyTests.swift
//  
//
//  Created by Victor C Tavernari on 25/03/2023.
//

import XCTest
@testable import StringContainsOperators

final class RegexSearchStrategyTests: XCTestCase {

    let validString = "Hello blue planet"
    let invalidString = "---"

    func testStringInput() throws {

        let strategy = RegexSearchStrategy(input: .string("^Hell.*$"))

        XCTAssertTrue(try strategy.evaluate(string: self.validString))
        XCTAssertFalse(try strategy.evaluate(string: self.invalidString))
    }

    func testPredicateInputs() throws {

        let strategy = RegexSearchStrategy(input:
                .predicate(.regexp(.string("^Hell.*$")))
        )

        XCTAssertThrowsError(try strategy.evaluate(string: self.validString))
        XCTAssertThrowsError(try strategy.evaluate(string: self.invalidString))
    }
}
