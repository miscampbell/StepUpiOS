//
//  StringExtension.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 22/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

extension String {
    public var notification: Notification.Name {
        return Notification.Name(rawValue: self)
    }
    
    public func fontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: self, size: size)!
    }
}
