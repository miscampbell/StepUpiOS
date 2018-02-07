//
//  ValueConverterHelperTest.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 18/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import XCTest
@testable import StepUpiOS

class ValueConverterHelperTest: GoalsTests
{
    func testMilesToKilometres()
    {
        do {
            let value:Double = try ValueConverter.convertValue(from: .Miles, to: .Kilometres, value: 10.2)
            XCTAssertEqual(value, 16.4, "Expected Kilometres to be 16.4 km")
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testKilometresToMiles()
    {
        do {
            let value:Double = try ValueConverter.convertValue(from: .Kilometres, to: .Miles, value: 16.4)
            XCTAssertEqual(value, 10.2, "Expected Miles to be 10.2 miles")
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testKilogramsToStones()
    {
        do {
            let value:Double = try ValueConverter.convertValue(from: .Kilograms, to: .Stones, value: 100)
            XCTAssertEqual(value, 15.7, "Expected Stones/Lbs to be 15.7 stones/lbs")
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testStonesToKilograms()
    {
        do {
            let value:Double = try ValueConverter.convertValue(from: .Stones, to: .Kilograms, value: 15.7)
            XCTAssertEqual(value, 99.7, "Expected Kilograms to be 99.7")
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testCentimetresToFeet()
    {
        do {
            let value:Double = try ValueConverter.convertValue(from: .Centimetres, to: .Feet, value: 190)
            XCTAssertEqual(value, 6.2, "Expected Feet to be 6.2")
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testFeetToCentimetres()
    {
        do {
            let value:Double = try ValueConverter.convertValue(from: .Feet, to: .Centimetres, value: 6.2)
            XCTAssertEqual(value, 189, "Expected Feet to be 6.2")
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testInvalidConvertson()
    {
        do {
            let _:Double = try ValueConverter.convertValue(from: .Stones, to: .Miles, value: 15.7)
            XCTAssertTrue(false, "Invalid conversion from Stones to Mile")
        } catch {
            XCTAssertTrue(type(of: error) == type(of: ValueConverterError.InvalidConversion))
        }
    }
}
