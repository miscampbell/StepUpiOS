//
//  IsEmptyValidation.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 06/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

open class IsEmptyValidation:BaseValidation, ValidationProtocol {
    public func validate(_ value: Any?) -> Bool {
        if let val = value as? String {
            let whitespaceString = val.trimmingCharacters(in: CharacterSet.whitespaces)
            if whitespaceString.isEmpty {
                return false
            }
        }
        
        return true
    }
}
