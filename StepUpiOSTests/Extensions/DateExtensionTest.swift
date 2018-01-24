//
//  DateExtensionTest.swift
//  StepUpiOSTests
//
//  Created by Michael Miscampbell on 22/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import XCTest
@testable import StepUpiOS

class DateExtensionTest: XCTestCase {
    func testRhubarbDate()
    {
        XCTAssertNotNil("1984-12-19T00:00:00-0500".dateFromRFC339, "Rhubarb Date format was nil")
    }
}
