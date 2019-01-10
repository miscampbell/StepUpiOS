//
//  FileManagerExtension.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 03/08/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

extension FileManager {
    public var documentsPath: String? {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        return documentsPath
    }
}
