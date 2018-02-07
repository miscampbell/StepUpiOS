//
//  IsEmptyValidationTest.swift
//  StepUpiOSTests
//
//  Created by Michael Miscampbell on 06/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import XCTest
@testable import StepUpiOS

class IsEmptyValidationTest: XCTestCase {
    func testIsEmptyValidation()
    {
        var emptyValidation = IsEmptyValidation()
        XCTAssertFalse(emptyValidation.validate("     ")
        XCTAssertFalse(emptyValidation.validate("")
        XCTAssertTrue(emptyValidation.validate(" Testing ")
        XCTAssertTrue(emptyValidation.validate(" Te T TWE  ")
    }
}

