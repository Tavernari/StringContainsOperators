//
//  OrSearchStrategyTests.swift
//  
//
//  Created by Victor C Tavernari on 25/03/2023.
//

import XCTest
@testable import StringContainsOperators

final class OrSearchStrategyTests: XCTestCase {

    let validString = "Hello blue planet"
    let invalidString = "---"

    func testStringInputs() throws {

        let strategy = OrSearchStrategy(input: [
            .string("blue"),
            .string("planet"),
            .string("Hello")
        ])

        XCTAssertTrue(try strategy.evaluate(string: self.validString))
        XCTAssertFalse(try strategy.evaluate(string: self.invalidString))
    }

    func testPredicateInputs() throws {

        let strategy = OrSearchStrategy(input: [
            .predicate(.or([.string("blue"),
                            .string("red")])),
            .predicate(.or([.string("Hello"),
                            .string("Hi")])),
            .predicate(.or([.string("world"),
                            .string("planet")]))
        ])

        XCTAssertTrue(try strategy.evaluate(string: self.validString))
        XCTAssertFalse(try strategy.evaluate(string: self.invalidString))
    }

    func testPredicateAndStringInputs() throws {

        let strategy = OrSearchStrategy(input: [
            .predicate(.or([.string("blue"),
                            .string("red")])),
            .string("Hello"),
            .string("planet")
        ])

        XCTAssertTrue(try strategy.evaluate(string: self.validString))
        XCTAssertFalse(try strategy.evaluate(string: self.invalidString))
    }
}
