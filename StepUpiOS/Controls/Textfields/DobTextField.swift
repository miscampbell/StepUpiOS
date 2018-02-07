//
//  DobTextfieldControl.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 22/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import UIKit

open class DobTextField: ImageTextField, ControlValueProtocol {
    public typealias valueTypeToGet = Date
    public typealias valueTypeToSet = Date
    
    var dateFormat: String = "dd MMMM YYYY"
    
    override func initialiseView() {
        super.initialiseView()
        
        let datePicker = CustomDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.addTarget(self, action: #selector(self.onDatePickerChanged(_:)), for: .valueChanged)
        datePicker.backgroundColor = inputViewBackgroundColor
        datePicker.tintColor = UIColor.clear
        self.inputView = datePicker
        self.inputView?.backgroundColor = inputViewBackgroundColor
    }
    
    @objc private func onDatePickerChanged(_ sender: UIDatePicker)
    {
        let dateText = "\(sender.date.daySuffix)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        let dateString:NSMutableString = NSMutableString(string:dateFormatter.string(from: sender.date))
        dateString.insert(dateText, at: 2)
        
        self.text = dateString as String
        
        initiateValidation()
    }
    
    public func getValue() -> Date {
        let datePicker = self.inputView as! UIDatePicker
        return datePicker.date
    }
    
    public func setValue(_ value: Date) {
        let datePicker = self.inputView as! UIDatePicker
        datePicker.date = value
        self.onDatePickerChanged(datePicker)
    }
    
    override func inputViewBackgroundColorChanged(_ newColor: UIColor?) {
        if let inputDatePickerView = self.inputView as? CustomDatePicker {
            inputDatePickerView.inputViewBackgroundColor = newColor
        }
    }
    
    override func initiateValidation() {
        _ = validate(getValue())
    }
}

private class CustomDatePicker: UIDatePicker
{
    var inputViewBackgroundColor: UIColor?
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        self.backgroundColor = inputViewBackgroundColor
    }
}
