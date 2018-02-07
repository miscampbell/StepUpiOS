//
//  BaseValidation.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 06/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

open class BaseValidation: ValidationProtocol
{
    public var validationErrors: [String] = []
    
    public init() {
    }
    
    public func validate(_ value: Any?) -> Bool {
        fatalError("BaseValidation validate method should always be overridden")
        return false
    }
}
