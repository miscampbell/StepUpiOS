//
//  DateValidation.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 06/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

open class DateOfBirthValidation: BaseValidation {
    var minimumDateOfBirth: Date
    
    public init(_ minimumDateOfBirth: Date) {
        self.minimumDateOfBirth = minimumDateOfBirth
    }
    
    public override func validate(_ value: Any?) -> Bool {
        if let dateValue = value as? Date, dateValue > minimumDateOfBirth {
            return false
        }
        
        return true
    }
}
