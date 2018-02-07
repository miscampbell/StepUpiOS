//
//  PasswordTextfieldControl.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 22/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import UIKit

open class PasswordTextField: ImageTextField {
    override func initialiseView() {
        super.initialiseView()
        self.isSecureTextEntry = true
    }
}
