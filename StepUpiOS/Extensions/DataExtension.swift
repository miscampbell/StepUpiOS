//
//  DataExtension.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 10/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

extension Data {
    public var contentType: String {
        let array = [UInt8](self)
        let contentType: String
        switch (array[0]) {
            case 0xFF:
                contentType = "image/jpg"
            case 0x89:
                contentType = "image/png"
            case 0x47:
                contentType = "image/gif"
            case 0x49, 0x4D :
                contentType = "image/tiff"
            default:
                contentType = "unknown"
        }
        return contentType
    }
}
