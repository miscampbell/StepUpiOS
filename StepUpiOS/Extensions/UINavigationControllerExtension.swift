//
//  UINavigationControllerExtension.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 23/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

extension UINavigationController {
    open override var childViewControllerForStatusBarHidden: UIViewController? {
        return topViewController
    }
    
    open override var childViewControllerForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    public func resetRootViewController(_ viewController: UIViewController, animated: Bool = false) {
        self.pushViewController(viewController, animated: animated)
        self.viewControllers = [viewController]
    }
}
