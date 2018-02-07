//
//  ControlValueProtocol.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 03/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

public protocol ControlValueProtocol {
    associatedtype valueTypeToGet
    func getValue() -> valueTypeToGet
    
    associatedtype valueTypeToSet
    func setValue(_ value: valueTypeToSet)
}
