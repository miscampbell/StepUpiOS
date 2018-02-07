//
//  UIDatePickerExtension.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 03/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

extension UIPickerView {
    open override var backgroundColor: UIColor? {
        didSet {
            draw(self.frame)
        }
    }
}
