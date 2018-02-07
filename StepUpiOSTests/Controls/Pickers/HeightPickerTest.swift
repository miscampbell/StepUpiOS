//
//  HeightPickerViewTest.swift
//  StepUpiOSTests
//
//  Created by Michael Miscampbell on 05/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import XCTest
@testable import StepUpiOS

class HeightPickerTest: XCTestCas {
    var testHeightValue: HeightValue = {
        return HeightValue(firstValue: NSNumber(value: 193), secondValue: NSNumber(value: 0), measurement: .centimetres)
    }
    
    func testSetHeightValue()
    {
        let heightPicker = HeightPicker(nil, customBackgroundColor: nil)
        XCTAssert(heightPicker.selectedRow(inComponent: 0) == 0)
        XCTAssert(heightPicker.selectedRow(inComponent: 1) == 0)
        XCTAssert(heightPicker.selectedRow(inComponent: 2) == 0)
        
        heightPicker.setValue(testHeightValue)
    }
    
    func testChangeHeightMeasurement()
    {
        XCTAssert(true)
    }
}
