//
//  DiacriticAndCaseInsensitiveSearchStrategyTests.swift
//  
//
//  Created by Victor C Tavernari on 25/03/2023.
//

import XCTest
@testable import StringContainsOperators

final class DiacriticAndCaseInsensitiveSearchStrategyTests: XCTestCase {

    let validString = "Hello blue planet"
    let invalidString = "---"

    func testStringInput() throws {

        let strategy = DiacriticAndCaseInsensitiveSearchStrategy(input: .string("héllo"))

        XCTAssertTrue(try strategy.evaluate(string: self.validString))
        XCTAssertFalse(try strategy.evaluate(string: self.invalidString))
    }

    func testPredicateInputs() throws {

        let strategy = DiacriticAndCaseInsensitiveSearchStrategy(input:
                .predicate(.diacriticAndCaseInsensitive(.string("héllo")))
        )

        XCTAssertThrowsError(try strategy.evaluate(string: self.validString))
        XCTAssertThrowsError(try strategy.evaluate(string: self.invalidString))
    }
}
