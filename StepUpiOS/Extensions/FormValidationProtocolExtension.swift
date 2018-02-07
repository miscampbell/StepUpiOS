//
//  FormValidationProtocolExtension.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 06/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

extension FormValidationProtocol
{
    public mutating func addControl(_ control: ControlValidationProtocol)
    {
        self.controlsToValidate.append(control)
    }
    
    public func validate(_ value:Any) -> Bool
    {
        for control in controlsToValidate {
            if !control.validate(value) {
                return false
            }
        }
        
        return true
    }
}
