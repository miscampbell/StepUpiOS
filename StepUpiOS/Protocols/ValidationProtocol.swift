//
//  InputValidationProtocol.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 06/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

public protocol ValidationProtocol {
    var validationErrors: [String] { get set }
    
    func validate(_ value: Any?) -> Bool
}
