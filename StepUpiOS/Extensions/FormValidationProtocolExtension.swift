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
    public func validate() -> Bool
    {
        for control in controlsToValidate {
            if !control.validate() {
                return false
            }
        }
        
        return true
    }
}
