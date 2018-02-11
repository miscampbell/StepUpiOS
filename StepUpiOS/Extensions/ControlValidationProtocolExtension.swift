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
    
    public mutating func addValidationDependency(_ controlValidation: ControlValidationProtocol)
    {
        validationDependencies.append(controlValidation)
    }
    
    public func validate(_ shouldValidateDependencies: Bool = true) -> Bool
    {
        if shouldValidateDependencies {
            for dependency in validationDependencies {
                _ = dependency.validate(false)
            }
        }
        
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
