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
    
    public var numbers: String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
    }
    
    public var uppercaseLetters: String {
        return self.components(separatedBy: CharacterSet.uppercaseLetters.inverted).joined(separator: "")
    }
    
    public var lowercaseLetters: String {
        return self.components(separatedBy: CharacterSet.uppercaseLetters.inverted).joined(separator: "")
    }
    
    public func specialCharacters(_ specialCharacterSet: CharacterSet) -> String {
        return self.components(separatedBy: specialCharacterSet.inverted).joined(separator: "")
    }
}
