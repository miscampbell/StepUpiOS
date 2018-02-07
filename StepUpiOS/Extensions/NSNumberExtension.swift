//
//  NumberFormatterExtension.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 05/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

extension NSNumber {
    func round(_ places: Int) -> String?
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = places
        formatter.roundingMode = .up
        
        return formatter.string(from: self)
    }
}

extension NumberFormatter {
    public static let stringToDouble: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
