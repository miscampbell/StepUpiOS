//
//  InputControlsView.swift
//  Goals
//
//  Created by Michael Miscampbell on 03/02/2016.
//  Copyright © 2016 Miscampbell App Design. All rights reserved.
//

import UIKit

@IBDesignable
open class KeyboardInputNavigationControl: UIView {
    public var previousActionBlock: (() -> Void)?
    public var nextActionBlock: (() -> Void)?
    public var doneActionBlock: (() -> Void)?
    
    private var bottomConstraint: NSLayoutConstraint!
    private var keyboardAppearance: UIKeyboardAppearance
    
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    
    @IBInspectable var previousButtonTextColor: UIColor? {
        didSet {
            self.previousButton.titleLabel?.textColor = previousButtonTextColor
        }
    }
    
    @IBInspectable var nextButtonTextColor: UIColor? {
        didSet {
            self.nextButton.titleLabel?.textColor = nextButtonTextColor
        }
    }
    
    @IBInspectable var doneButtonTextColor: UIColor? {
        didSet {
            self.doneButton.titleLabel?.textColor = doneButtonTextColor
        }
    }
    
    public init(attachToSuperView: UIView, keyboardApperance: UIKeyboardAppearance) {
        self.keyboardAppearance = keyboardApperance
        
        super.init(frame: CGRect.zero)
        loadViewFromNib()
        
        attachToSuperView.addSubview(self)
        attachToSuperView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["view": self]))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44))
        bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: attachToSuperView, attribute: .bottom, multiplier: 1.0, constant: 44)
        attachToSuperView.addConstraint(bottomConstraint)
        
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardInputNavigationControl.keyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardInputNavigationControl.keyboardDidShowNotification(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        self.keyboardAppearance = .default
        super.init(coder: aDecoder)
    }
    
    fileprivate func loadViewFromNib() {
        self.translatesAutoresizingMaskIntoConstraints = false
        let view = UINib(nibName: "KeyboardInputNavigationControl", bundle: Bundle(for: type(of: self))).instantiate(withOwner: self, options: nil)[0] as? UIView
        view?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view!)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["view": view!]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["view": view!]))
        
        view?.backgroundColor = keyboardAppearanceBackgroundColor()
    }

    @IBAction func onPreviousButtonSelected(_ sender:UIButton) {
        previousActionBlock?()
    }
    
    @IBAction func onNextButtonSelected(_ sender:UIButton) {
        nextActionBlock?()
    }
    
    @IBAction func onDoneButtonSelected(_ sender:UIButton) {
        doneActionBlock?()
    }
    
    
    //  MARK: Keyboard Avoidance
    @objc fileprivate func keyboardWillHideNotification(_ notification: Notification)
    {
        self.bottomConstraint.constant = self.frame.height
        let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let animationOptions = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions(rawValue: UInt(animationOptions.intValue) << 16) , animations: { () -> Void in
            self.layoutIfNeeded()
            }, completion: { (completed) -> Void in
                
        })
    }
    
    @objc fileprivate func keyboardDidShowNotification(_ notification: Notification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        {
            self.bottomConstraint.constant = -keyboardSize.height
            let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
            let animationOptions = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
            UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions(rawValue: UInt(animationOptions.intValue) << 16), animations: { () -> Void in
                    self.layoutIfNeeded()
                }, completion: { (completed) -> Void in
                    
            })
        }
    }
    
    fileprivate func keyboardAppearanceBackgroundColor() -> UIColor
    {
        var keyboardApperanceColor = UIColor.clear
        switch (keyboardAppearance) {
            case .dark:
                keyboardApperanceColor = UIColor(rgba: "#000000")
                break
            case .default, .light:
                keyboardApperanceColor = UIColor(rgba: "#ABB3BD")
                break
        }
        
        return keyboardApperanceColor
    }
}
