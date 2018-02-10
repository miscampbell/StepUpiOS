//
//  UIColorExtension.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 19/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

extension UIButton {
    open override var isHighlighted: Bool {
        didSet {
            let currentBackgroundColor = self.backgroundColor
            let currentTitleColor = self.titleLabel?.textColor

            if (isHighlighted) {
                self.backgroundColor = currentBackgroundColor?.withAlphaComponent(0.7)
                self.titleLabel?.textColor = currentTitleColor?.withAlphaComponent(0.7)
            } else {
                self.backgroundColor = currentBackgroundColor?.withAlphaComponent(1.0)
                self.titleLabel?.textColor = currentTitleColor?.withAlphaComponent(1.0)
            }
        }
    }
}
