//
//  FormValidationProtocol.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 06/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

public protocol FormValidationProtocol {
    var controlsToValidate:[ControlValidationProtocol] { get set }
    var validationErrors:[String] { get set }
}
