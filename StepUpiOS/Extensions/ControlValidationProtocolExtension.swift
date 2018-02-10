//
//  ControlValidationExtension.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 06/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

extension ControlValidationProtocol {
    public mutating func addValidation(_ validation: ValidationProtocol)
    {
        validations.append(validation)
    }
    
    public func validate() -> Bool
    {
        for validation in validations {
            if !validation.validate(self.getValueToValidate()) {
                self.validationActionBlock?(false)
                return false
            }
        }
        
        self.validationActionBlock?(true)
        return true
    }
}
