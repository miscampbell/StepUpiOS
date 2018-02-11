//
//  ImageButton.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 18/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

@IBDesignable
open class ImageButton: UIButton {
    @IBInspectable var iconImage: UIImage? {
        didSet {
            self.iconImageView.image = iconImage
        }
    }
    @IBInspectable public var cornerRadius: CGFloat = 2.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    private var iconImageView: UIImageView!
    
    public required init() {
        super.init(frame: .zero)
        initialiseView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialiseView()
    }
    
    private func initialiseView()
    {
        translatesAutoresizingMaskIntoConstraints = false
        addIconImageView()
    }
    
    private func addIconImageView()
    {
        let imageView:UIImageView = UIImageView(image: nil)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[imageView(20)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["imageView": imageView]))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0))
        imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 20))
        
        self.iconImageView = imageView
    }
}
