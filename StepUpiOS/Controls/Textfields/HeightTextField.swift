//
//  HeightTextfieldControl.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 22/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import UIKit

open class HeightTextField: ImageTextField, ControlValueProtocol, HeightPickerDelegate  {
    @IBInspectable var pickerViewBackgroundColor: UIColor? {
        didSet {
            let heightPicker = self.inputView as! HeightPicker
            heightPicker.backgroundColor = pickerViewBackgroundColor
        }
    }
    
    override func initialiseView() {
        super.initialiseView()
        let heightPickerView = HeightPicker(self, customBackgroundColor: pickerViewBackgroundColor)
        self.inputView = heightPickerView
    }
    
    func heightValueChanged(_ value: HeightValue) {
        setValue(value)
    }
    
    typealias valueTypeToGet = HeightValue
    typealias valueTypeToSet = HeightValue
    
    func getValue() -> HeightValue {
        let heightPickerView = self.inputView as! HeightPicker
        return heightPickerView.getValue()
    }
    
    func setValue(_ value: HeightValue) {
        self.text = value.stringValue
    }
}

struct HeightValue {
    let firstValue: NSNumber
    let secondValue: NSNumber
    let measurement: HeightMeasurement
    let calculatedValue: NSNumber?
    
    init(firstValue: NSNumber, secondValue: NSNumber, measurement: HeightMeasurement) {
        self.firstValue = firstValue
        self.secondValue = secondValue
        self.measurement = measurement
        self.calculatedValue = NumberFormatter.stringToDouble.number(from: "\(firstValue.stringValue).\(secondValue.stringValue)")
    }
    
    var stringValue: String {
        get {
            var value = ""
            
            switch measurement {
                case .centimetres:
                    value = "\(firstValue.stringValue).\(secondValue.stringValue)"
                case .feetInches:
                    value = "\(firstValue.stringValue).\(secondValue.stringValue)"
            }
            
            return "\(value) \(measurement.stringValue)"
        }
    }
}

enum HeightMeasurement: Int {
    case centimetres = 0
    case feetInches = 1
    
    var stringValue: String {
        get {
            switch self {
                case .centimetres:
                    return "cm"
                case .feetInches:
                    return "ft/inches"
            }
        }
    }
}


