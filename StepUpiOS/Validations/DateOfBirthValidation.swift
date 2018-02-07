//
//  DateValidation.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 06/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

open class DateOfBirthValidation: BaseValidation, ValidationProtocol {
    var minimumDateOfBirth: Date
    
    init(_ minimumDateOfBirth: Date) {
        self.minimumDateOfBirth = minimumDateOfBirth
    }
    
    public func validate(_ value: Any?) -> Bool {
        if let dateValue = value as? Date, minimumDateOfBirth >= dateValue {
            return false
        }
        
        return true
    }
}
