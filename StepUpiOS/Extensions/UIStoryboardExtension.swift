//
//  UIStoryboardExtension.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 09/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

extension UIStoryboard {
    public static func instantiateViewController<T: UIViewController>(_ identifier: String, _ storyboardName:String = "Main") -> T
    {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier) as! T
        
        return vc
    }
}
