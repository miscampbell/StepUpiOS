//
//  EmailAddressValidationTest.swift
//  StepUpiOSTests
//
//  Created by Michael Miscampbell on 06/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import XCTest
@testable import StepUpiOS

class EmailAddressValidationTest: XCTestCase {
    func testEmailAddressValidation() {
        let emptyValidation = EmailAddressValidation()
        XCTAssertFalse(emptyValidation.validate("testing"))
        XCTAssertFalse(emptyValidation.validate("    "))
        XCTAssertTrue(emptyValidation.validate(" test@test.com "))
        XCTAssertTrue(emptyValidation.validate("michael.testing@play.com"))
    }
}
