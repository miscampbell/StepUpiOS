//
//  GenderSegmentedControl.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 22/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import UIKit

open class GenderSegmentedControl: UISegmentedControl
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
    
    func setValue(_ gender: String?)
    {
        let index = segments.index(of: gender ?? "")
        guard let selectedIndex = index else {
            self.selectedSegmentIndex = 0
            return
        }
        self.selectedSegmentIndex = selectedIndex
    }
    
    func getValue() -> Gender
    {
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
