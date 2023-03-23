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
}
