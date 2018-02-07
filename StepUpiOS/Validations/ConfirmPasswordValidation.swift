//
//  ConfirmPasswordValidation.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 07/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

open class ConfirmPasswordValidation: BaseValidation
{
    private let otherPasswordInput: UITextField
    
    public init(_ otherPasswordInput: UITextField) {
        self.otherPasswordInput = otherPasswordInput
    }
    
    public override func validate(_ value: Any?) -> Bool {
        if let passwordValue = value as? String, let otherPasswordValue = otherPasswordInput.text, passwordValue == otherPasswordValue {
            return true
        }
        
        return false
    }
}
