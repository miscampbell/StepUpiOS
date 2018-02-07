//
//  EmailAddressValidation.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 06/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

open class EmailAddressValidation: BaseValidation
{
    private static let EmailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    private let emailPredicate = NSPredicate(format: "SELF MATCHES %@", EmailRegex)
    
    public override func validate(_ value: Any?) -> Bool {
        return emailPredicate.evaluate(with: value)
    }
}
