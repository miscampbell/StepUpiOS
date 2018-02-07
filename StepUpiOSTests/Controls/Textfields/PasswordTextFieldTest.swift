//
//  PasswordTextfieldControlTest.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 22/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import XCTest
@testable import StepUpiOS

class PasswordTextFieldTest: GoalsTests
{
    public func testInvalidPasswordValidation()
    {
        let passwordTextfield = PasswordTextfieldControl()
        let confirmPasswordTextfield = PasswordTextfieldControl()
        
        passwordTextfield.setValue("Testing")
        confirmPasswordTextfield.setValue("Testing1234")
        
        passwordTextfield.setOtherPasswordTextfield(confirmPasswordTextfield)
        
        XCTAssert(passwordTextfield.validationErrors.count == 0)
        
        passwordTextfield.validateInput()
        
        XCTAssert(passwordTextfield.validationErrors.count > 0)
    }
    
    public func testPasswordFormatInvalidValidation()
    {
        let passwordTextfield = PasswordTextfieldControl()
        let confirmPasswordTextfield = PasswordTextfieldControl()
        
        passwordTextfield.setValue("Test")
        confirmPasswordTextfield.setValue("Test")
        
        passwordTextfield.setOtherPasswordTextfield(confirmPasswordTextfield)
        
        passwordTextfield.validateInput()
        
        XCTAssert(passwordTextfield.validationErrors.count > 0)
        XCTAssert(passwordTextfield.validationErrors[0].name == InvalidPasswordFoundError, "Expected password format to be invalid")
        XCTAssertTrue(passwordTextfield.validationErrors[0].description == "Please enter a valid Password")
    }
    
    public func testValidPasswordValidation()
    {
        let passwordTextfield = PasswordTextfieldControl()
        let confirmPasswordTextfield = PasswordTextfieldControl()
        
        passwordTextfield.setValue("Testing")
        confirmPasswordTextfield.setValue("Testing")
        
        passwordTextfield.setOtherPasswordTextfield(confirmPasswordTextfield)
        
        passwordTextfield.validateInput()
        
        XCTAssert(passwordTextfield.validationErrors.count == 0)
        XCTAssert(confirmPasswordTextfield.validationErrors.count == 0)
    }
    
}

