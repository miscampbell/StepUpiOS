//
//  GenderSegmentedControl.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 22/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import UIKit

open class GenderSegmentedControl: UISegmentedControl, ControlValueProtocol
{
    private let segments = [Gender.Male.rawValue, Gender.Female.rawValue]
    
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        configureView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    private func configureView()
    {
        self.removeAllSegments()
        
        var count = 0
        for gender in segments {
            self.insertSegment(withTitle: gender, at: count, animated: true)
            count += 1
        }
    
        self.selectedSegmentIndex = 0
    }

    public typealias valueTypeToSet = Gender
    public func setValue(_ value: Gender) {
        switch value {
            case .Female:
                self.selectedSegmentIndex = 1
            default:
                self.selectedSegmentIndex = 1
        }
    }
    
    public typealias valueTypeToGet = Gender
    public func getValue() -> Gender {
        var gender = Gender.Male
        if self.selectedSegmentIndex == 1
        {
            gender = Gender.Female
        }
        
        return gender
    }
}

public enum Gender: String
{
    case Male = "Male"
    case Female = "Female"
}
