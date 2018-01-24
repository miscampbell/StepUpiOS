//
//  MiOSWorkingViewController.swift
//  Goals
//
//  Created by Michael Miscampbell on 23/12/2016.
//  Copyright © 2016 Miscampbell App Design. All rights reserved.
//

import UIKit

public class WorkingViewController: UIViewController {
    
    @IBOutlet private var loadingSpinnerView:UIView!
    @IBOutlet private var loadingSpinnerLabel:UILabel!
    @IBOutlet private var loadingImageView:UIImageView!
    
    public static let sharedInstance:WorkingViewController = {
        let instance = WorkingViewController()
        return instance
    }()
    
    private init() {
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        setupView()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView()
    {
        if let rootViewController = UIApplication.shared.keyWindow {
            self.view.translatesAutoresizingMaskIntoConstraints = false
            rootViewController.addSubview(self.view)
            rootViewController.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[workingVC]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["workingVC": self.view]))
            rootViewController.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[workingVC]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["workingVC": self.view]))
        }
        
        self.view.isHidden = true
        self.loadingSpinnerView.layer.cornerRadius = 10;
        self.loadingSpinnerView.layer.masksToBounds = true
        
//        var imagesArray:[UIImage] = []
//        for i in 0...29 {
//            imagesArray.append(UIImage(named: "frame_\(i)_delay-0.03s.gif")!)
//        }
//        self.loadingImageView.animationImages = imagesArray
//        self.loadingImageView.animationRepeatCount = 0
//        self.loadingImageView.contentMode = .scaleAspectFit
//        self.loadingImageView.startAnimating()
    }
    
    public func show()
    {
        OperationQueue.main.addOperation { 
            self.view.isHidden = false
            self.view.layer.zPosition = 1
        }
    }
    
    public func hide()
    {
        OperationQueue.main.addOperation {
            self.view.isHidden = true
            self.view.layer.zPosition = 1
        }
    }
}
