//
//  KMPTests.swift
//  Tests
//
//  Created by Andreas Neusüß on 31/24/16.
//  Copyright © 2016 Swift Algorithm Club. All rights reserved.
//

import Foundation
import XCTest

class KMPTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func assert(pattern: String, doesNotExistsIn string: String) {
        let index = string.index(of: pattern)
        XCTAssertNil(index)
    }

    func assert(pattern: String, existsIn string: String) {
        let index = string.index(of: pattern)
        XCTAssertNotNil(index)

        let startIndex = string.index(string.startIndex, offsetBy: index!)
        let endIndex = string.index(string.index(string.startIndex, offsetBy: index!), offsetBy: pattern.characters.count)
        
        let match = string.substring(with: startIndex..<endIndex)
        XCTAssertEqual(match, pattern)
    }

    func testSearchPatternInEmptyString() {
        let string = ""
        let pattern = "ABCDEF"
        assert(pattern: pattern, doesNotExistsIn: string)
    }

    func testSearchEmptyPatternString() {
        let string = "ABCDEF"
        let pattern = ""
        assert(pattern: pattern, doesNotExistsIn: string)
    }

    func testSearchPatternLongerThanString() {
        let string = "ABC"
        let pattern = "ABCDEF"
        assert(pattern: pattern, doesNotExistsIn: string)
    }

    func testSearchTheSameString() {
        let string = "ABCDEF"
        let pattern = "ABCDEF"
        assert(pattern: pattern, existsIn: string)
    }

    func testSearchAPreffix() {
        let string = "ABCDEFGHIJK"
        let pattern = "ABCDEF"
        assert(pattern: pattern, existsIn: string)
    }

    func testSearchASuffix() {
        let string = "ABCDEFGHIJK"
        let pattern = "HIJK"
        assert(pattern: pattern, existsIn: string)
    }

    func testSearchAStringFromTheMiddle() {
        let string = "ABCDEFGHIJK"
        let pattern = "EFG"
        assert(pattern: pattern, existsIn: string)
    }

    func testSearchInvalidPattern() {
        let string = "ABCDEFGHIJK"
        let pattern = "AEF"
        assert(pattern: pattern, doesNotExistsIn: string)
    }

    func testSearchPatternWithDuplicatedCharacter() {
        let string = "Goal: Write a string search algorithm in pure Swift "
                     + "without importing Foundation or using NSString's rangeOfString() method."
        let pattern = "NSS"
        assert(pattern: pattern, existsIn: string)
    }

    func testSearchInvalidPatternWithDuplicatedCharacter() {
        let string = "Goal: Write a string search algorithm in pure Swift "
            + "without importing Foundation or using NSString's rangeOfString() method."
        let pattern = "nss"
        assert(pattern: pattern, doesNotExistsIn: string)
    }
}
