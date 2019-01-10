//
//  GenderSegmentedControlTest.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 22/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//


import XCTest
@testable import StepUpiOS

class GenderSegmentedControlTest: XCTestCase
{
    public func testSetValue()
    {
        let genderControl = GenderSegmentedControl()
        genderControl.setValue(Gender.Female)
        XCTAssertEqual(genderControl.selectedSegmentIndex, 1)
    }
    
    public func testGetValue()
    {
        let genderControl = GenderSegmentedControl()
        genderControl.setValue(Gender.Male)
        let gender:Gender = genderControl.getValue()
        XCTAssertEqual(gender, Gender.Male)
        XCTAssertEqual(genderControl.selectedSegmentIndex, 0)
    }
}
