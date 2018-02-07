//
//  ImageTextfield.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 22/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

@IBDesignable
open class ImageTextField: UITextField, UITextFieldDelegate, ControlValidationProtocol {
    public var validations: [ValidationProtocol] = []
    public var validationActionBlock: ((Bool) -> Void)?
    
    @IBInspectable public var indicatorImage: UIImage? {
        didSet {
            if indicatorImageView == nil {
                addIndicatorImage()
            }
            
            if let indicatorImageTemplate = indicatorImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate) {
                self.indicatorImageView?.image = indicatorImageTemplate
            }
        }
    }
    @IBInspectable public var indicatorImageTintColor: UIColor = UIColor.white {
        didSet {
            self.indicatorImageView?.tintColor = indicatorImageTintColor
        }
    }
    private var indicatorImageView: UIImageView?
    
    @IBInspectable public var inset: CGFloat = 5
    @IBInspectable public var defaultImageSize: CGFloat = 16
    
    @IBInspectable public var bottomBar: Bool = false {
        didSet {
            if bottomBar {
                addBottomBar()
            }
        }
    }
    @IBInspectable public var bottomBarColor: UIColor = UIColor.white {
        didSet {
            self.bottomSeparatorView?.backgroundColor = bottomBarColor
        }
    }
    @IBInspectable public var bottomBarHeight: CGFloat = 1.5
    
    private var bottomSeparatorView: UIView?
    
    @IBInspectable public var checkboxImage: UIImage? {
        didSet {
            if checkboxImageView == nil {
                addCheckboxImage()
            }
            self.checkboxImageView?.image = checkboxImage
        }
    }
    public var checkboxImageView: UIImageView?
    
    @IBInspectable public var inputViewBackgroundColor: UIColor? {
        didSet {
            self.inputView?.backgroundColor = inputViewBackgroundColor
            self.inputViewBackgroundColorChanged(inputViewBackgroundColor)
        }
    }
    
    public required init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.delegate = self
        initialiseView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        initialiseView()
    }
    
    internal func initialiseView()
    {
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
        addIndicatorImage()
        addBottomBar()
        addCheckboxImage()
    }

    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: (inset * 3.5) + defaultImageSize, dy: inset)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: (inset * 3.5) + defaultImageSize, dy: inset)
    }
    
    private func addIndicatorImage()
    {
        if let indicatorImage = indicatorImage {
            indicatorImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        }
        
        indicatorImageView = UIImageView(image: indicatorImage)
        indicatorImageView!.contentMode = UIViewContentMode.scaleAspectFit
        indicatorImageView!.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.indicatorImageView!)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-inset-[indicatorImageView(width)]", options: NSLayoutFormatOptions(), metrics: ["width": defaultImageSize, "inset": inset], views: ["indicatorImageView": indicatorImageView!]))
        self.addConstraint(NSLayoutConstraint(item: indicatorImageView!, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0))
        indicatorImageView!.addConstraint(NSLayoutConstraint(item: indicatorImageView!, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: defaultImageSize))
        
        indicatorImageView!.tintColor = indicatorImageTintColor
    }
    
    private func addBottomBar()
    {
        if !bottomBar {
            return
        }
        
        let bottomSeperator = UIView()
        bottomSeperator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomSeperator)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bottomSeperator]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["bottomSeperator": bottomSeperator]))
        bottomSeperator.addConstraint(NSLayoutConstraint(item: bottomSeperator, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: self.bottomBarHeight))
        self.addConstraint(NSLayoutConstraint(item: bottomSeperator, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 10))
        
        bottomSeperator.backgroundColor = self.bottomBarColor
        
        self.bottomSeparatorView = bottomSeperator
    }
    
    func addCheckboxImage() {
        guard let checkboxImage = checkboxImage else {
            return
        }
        
        checkboxImageView = UIImageView(image: checkboxImage)
        checkboxImageView!.translatesAutoresizingMaskIntoConstraints = false
        
        checkboxImageView!.backgroundColor = UIColor.clear
        checkboxImageView!.isHidden = true
        
        self.addSubview(checkboxImageView!)
        
        checkboxImageView!.addConstraint(NSLayoutConstraint(item: checkboxImageView!, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 20))
        
        checkboxImageView!.addConstraint(NSLayoutConstraint(item: checkboxImageView!,
                                                        attribute: NSLayoutAttribute.width,
                                                        relatedBy: NSLayoutRelation.equal,
                                                        toItem: nil,
                                                        attribute: NSLayoutAttribute.notAnAttribute,
                                                        multiplier: 1.0,
                                                        constant: 20))
        
        self.addConstraint(NSLayoutConstraint(item: checkboxImageView!,
                                                         attribute: NSLayoutAttribute.trailing,
                                                         relatedBy: NSLayoutRelation.equal,
                                                         toItem: self,
                                                         attribute: NSLayoutAttribute.trailing,
                                                         multiplier: 1.0,
                                                         constant: -5))
        
        self.addConstraint(NSLayoutConstraint(item: checkboxImageView!,
                                                         attribute: NSLayoutAttribute.centerY,
                                                         relatedBy: NSLayoutRelation.equal,
                                                         toItem: self,
                                                         attribute: NSLayoutAttribute.centerY,
                                                         multiplier: 1.0,
                                                         constant: 0))
    }
 
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        NotificationCenter.default.post(name: Constants.Notification.TextFieldDidBeginEditing.notification, object: textField)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        _ = validate(textField.text)
        NotificationCenter.default.post(name: Constants.Notification.TextFieldDidEndEditing.notification, object: textField)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let shouldMoveToNextTextfield:Bool = textField.returnKeyType == UIReturnKeyType.next ? true : false
        NotificationCenter.default.post(name: Constants.Notification.TextFieldDidEndEditing.notification, object: textField)
        return shouldMoveToNextTextfield
    }
    
    internal func inputViewBackgroundColorChanged(_ newColor: UIColor?)
    {
    }
}
