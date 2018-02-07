//
//  HeightTextfieldControlTest.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 22/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import XCTest
@testable import StepUpiOS

class HeightTextFieldTest: GoalsTests
{
    public func testSetValue()
    {
        let textfield = HeightTextfieldControl()
        let heightValue = HeightValue(value: NSNumber(value: 193.4), type: "ft")
        textfield.setValue(heightValue)
        XCTAssertEqual(textfield.text, "6.3 ft")
    }
    
    public func testGetValue()
    {
        let textfield = HeightTextfieldControl()
        let heightValue = HeightValue(value: NSNumber(value: 193.4), type: "ft")
        textfield.setValue(heightValue)
        let value:HeightValue = textfield.getValue()
        XCTAssertEqual(value.value, NSNumber(value: 192), "ft")
    }
    
    public func testChangeMeasurementType()
    {
        let textfield = HeightTextfieldControl()
        let heightValue = HeightValue(value: NSNumber(value: 193.4), type: "ft")
        textfield.setValue(heightValue)
        let value:HeightValue = textfield.getValue()
        XCTAssertEqual(value.value, NSNumber(value: 192), "ft")
    }
}
