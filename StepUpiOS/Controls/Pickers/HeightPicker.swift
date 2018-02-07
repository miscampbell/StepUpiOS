//
//  HeightPickerView.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 22/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import UIKit

protocol HeightPickerDelegate {
    func heightValueChanged(_ value: HeightValue)
}

class HeightPicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate, ControlValueProtocol
{
    private var customBackgroundColor: UIColor?
    var heightPickerDelegate: HeightPickerDelegate?
    
    private var pickerHeightValue: HeightValue?
    
    init(_ delegate: HeightPickerDelegate, customBackgroundColor: UIColor?)
    {
        super.init(frame: CGRect.zero)
        self.heightPickerDelegate = delegate
        self.customBackgroundColor = customBackgroundColor
        self.initialiseView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialiseView()
    }
    
    private func initialiseView()
    {
        pickerHeightValue = getValue()
        
        if heightPickerDelegate == nil {
            Logger.warning(message: "HeightPickerDelegate not defined")
        }
        
        self.delegate = self
        self.dataSource = self
        
        if let customBackgroundColor = customBackgroundColor {
            self.backgroundColor = customBackgroundColor
        }
    }
    
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        switch pickerHeightValue!.measurement {
            case .centimetres:
                return numberOfRowsInComponentForCentimetres(component)
            case .feetInches:
                return numberOfRowsInComponentForFoot(component)
        }
    }

    private func numberOfRowsInComponentForCentimetres(_ component: Int) -> Int {
        switch component {
        case 0:
            return 300
        case 1:
            return 10
        default:
            return 2
        }
    }
    
    private func numberOfRowsInComponentForFoot(_ component: Int) -> Int {
        switch component {
        case 0:
            return 11
        case 1:
            return 13
        default:
            return 2
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        switch component {
        case 0:
            return "\(row)"
        case 1:
            return "\(row)"
        default:
            return HeightMeasurement(rawValue: row)?.stringValue ?? ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let previousHeightMeasurement = pickerHeightValue?.measurement
    
        //  Validate Measurement changing
        if component == 2, let heightMeasurement = HeightMeasurement(rawValue: row), previousHeightMeasurement?.rawValue != heightMeasurement.rawValue {
            if let calculatedValue = pickerHeightValue?.calculatedValue, let previousHeightMeasurement = previousHeightMeasurement {
                var valuesArray:[String] = []
                switch previousHeightMeasurement {
                    case .centimetres:
                        if let valArray = HeightConverter.convertCentimetresToFeetInches(calculatedValue)?.round(1)?.components(separatedBy: ".") {
                            valuesArray = valArray
                        }
                    case .feetInches:
                        if let valArray = HeightConverter.convertFeetInchesToCentimetres(calculatedValue)?.round(1)?.components(separatedBy: ".") {
                            valuesArray = valArray
                        }
                }
                
                self.pickerHeightValue = getValue()
                self.reloadAllComponents()
                
                if valuesArray.count > 1 {
                    self.selectRow(Int(valuesArray[0]) ?? 0, inComponent: 0, animated: true)
                    self.selectRow(Int(valuesArray[1]) ?? 0, inComponent: 1, animated: true)
                }
            }
        }
        let currentValue = getValue()
        self.pickerHeightValue = currentValue
        
        self.heightPickerDelegate?.heightValueChanged(currentValue)
    }
    
    typealias valueTypeToSet = HeightValue
    typealias valueTypeToGet = HeightValue
    
    func getValue() -> HeightValue {
        let firstValue = NSNumber(value: self.selectedRow(inComponent: 0))
        let secondValue = NSNumber(value: self.selectedRow(inComponent: 1))
        return HeightValue(firstValue: firstValue, secondValue: secondValue, measurement: HeightMeasurement(rawValue: self.selectedRow(inComponent: 2)) ?? .centimetres)
    }
    
    func setValue(_ value: HeightValue) {
        self.selectRow(value.firstValue.intValue, inComponent: 0, animated: true)
        self.selectRow(value.secondValue.intValue, inComponent: 1, animated: true)
        self.selectRow(value.measurement.rawValue, inComponent: 2, animated: true)
        
        self.pickerHeightValue = value
    }
}
