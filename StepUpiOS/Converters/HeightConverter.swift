//
//  HeightConverter.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 18/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

struct HeightConverter {
    private static let CM_TO_FEET = 30.48
    private static let FEET_TO_CM = 30.48
    
    static func convertCentimetresToFeetInches(_ value: NSNumber) -> NSNumber? {
        let cmValue = value.doubleValue
        let feetInches = NSNumber(value: cmValue / CM_TO_FEET)
        
        return feetInches
    }
    
    static func convertFeetInchesToCentimetres(_ value: NSNumber) -> NSNumber? {
        let feetInchesValue = value.doubleValue
        let centimetres = NSNumber(value: feetInchesValue * FEET_TO_CM)
        
        return centimetres
    }
}
