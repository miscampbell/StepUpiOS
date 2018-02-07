//
//  PasswordValidation.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 07/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

open class PasswordValidation: BaseValidation
{
    public var minimumLength: Int = 6
    public var maximumLength: Int = 0
    public var minimumRequiredNumbers: Int = 0
    public var minimumRequiredUppercaseLetters: Int = 0
    public var minimumRequiredLowercaseLetters: Int = 0
    public var minimumRequiredSpecialCharacters: Int = 0
    
    public var specialCharacterSet: CharacterSet = CharacterSet(charactersIn: "[(!@#$%^&*).]")
    
    public override func validate(_ value: Any?) -> Bool {
        validationErrors.removeAll()
        
        if let val = value as? String {
            
            if minimumLength > 0, val.count < minimumLength {
                validationErrors.append("Password must have a minimum length of \(minimumLength)")
            }
            
            if maximumLength > 0, val.count > maximumLength {
                validationErrors.append("Password exceeds maximum length of \(maximumLength)")
            }
            
            if minimumRequiredNumbers > 0, val.numbers.count < minimumRequiredNumbers {
                validationErrors.append("Password must have a minimum of \(minimumRequiredNumbers) numbers")
            }
            
            if minimumRequiredUppercaseLetters > 0, val.uppercaseLetters.count < minimumRequiredUppercaseLetters {
                validationErrors.append("Password must have a minimum of \(minimumRequiredUppercaseLetters) uppercase letters")
            }
            
            if minimumRequiredLowercaseLetters > 0, val.lowercaseLetters.count < minimumRequiredLowercaseLetters {
                validationErrors.append("Password must have a minimum of \(minimumRequiredLowercaseLetters) lowercase letters")
            }
            
            if minimumRequiredSpecialCharacters > 0, val.specialCharacters(specialCharacterSet).count < minimumRequiredLowercaseLetters {
                validationErrors.append("Password must have a minimum of \(minimumRequiredSpecialCharacters) special characters")
            }
        }
        
        return validationErrors.count == 0
    }
}
