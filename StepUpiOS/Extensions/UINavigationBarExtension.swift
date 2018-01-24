//
//  UINavigationBarExtension.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 23/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

extension UINavigationBar {
    public func makeTransparent() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.backgroundColor = UIColor.clear
        self.isTranslucent = true
    }
}
