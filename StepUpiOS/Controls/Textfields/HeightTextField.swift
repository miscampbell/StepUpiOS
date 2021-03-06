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
    
    public typealias valueTypeToGet = HeightValue
    public typealias valueTypeToSet = HeightValue
    
    public func getValue() -> HeightValue {
        let heightPickerView = self.inputView as! HeightPicker
        return heightPickerView.getValue()
    }
    
    public func setValue(_ value: HeightValue) {
        self.text = value.stringValue
    }
    
    public override func getValueToValidate() -> Any? {
        return getValue()
    }
}

public struct HeightValue {
    public let firstValue: NSNumber
    public let secondValue: NSNumber
    public let measurement: HeightMeasurement
    public let calculatedValue: NSNumber?
    
    public init(firstValue: NSNumber, secondValue: NSNumber, measurement: HeightMeasurement) {
        self.firstValue = firstValue
        self.secondValue = secondValue
        self.measurement = measurement
        self.calculatedValue = NumberFormatter.stringToDouble.number(from: "\(firstValue.stringValue).\(secondValue.stringValue)")
    }
    
    public var stringValue: String {
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

public enum HeightMeasurement: Int {
    case centimetres = 0
    case feetInches = 1
    
    public var stringValue: String {
        get {
            switch self {
                case .centimetres:
                    return "cm"
                case .feetInches:
                    return "ft/inches"
            }
        }
    }
    
    public static func measurement(_ value: String) -> HeightMeasurement
    {
        switch value {
            case "cm":
                return .centimetres
            case "ft":
                return .feetInches
            default:
                return .centimetres
        }
    }
}


