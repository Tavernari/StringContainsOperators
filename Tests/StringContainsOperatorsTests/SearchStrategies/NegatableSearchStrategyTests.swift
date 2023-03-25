//
//  NegatableSearchStrategy.swift
//  
//
//  Created by Victor C Tavernari on 25/03/2023.
//

import XCTest
@testable import StringContainsOperators

final class NegatablesSearchStrategyTests: XCTestCase {

    let validString = "Hello blue planet"
    let invalidString = "---"

    func testStringInput() throws {

        let strategy = NegatableSearchStrategy(input: .string("blue"))

        XCTAssertFalse(try strategy.evaluate(string: self.validString))
        XCTAssertTrue(try strategy.evaluate(string: self.invalidString))
    }

    func testPredicateInputs() throws {

        let strategy = NegatableSearchStrategy(input:
                .predicate(.negatable(.string("blue")))
        )

        XCTAssertTrue(try strategy.evaluate(string: self.validString))
        XCTAssertFalse(try strategy.evaluate(string: self.invalidString))
    }
}
