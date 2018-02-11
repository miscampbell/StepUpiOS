//
//  ControlValidationProtocol.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 06/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

public protocol ControlValidationProtocol {
    var validations: [ValidationProtocol] { get set }
    var validationActionBlock: ((_ success: Bool) -> Void)? { get set }
    
    var validationDependencies: [ControlValidationProtocol] { get set }
    
    mutating func addValidation(_ validation: ValidationProtocol)
    func validate(_ validateDependencies: Bool) -> Bool
    
    func getValueToValidate() -> Any?
}
