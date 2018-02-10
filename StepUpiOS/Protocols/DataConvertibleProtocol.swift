//
//  DataConvertibleProtocol.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 10/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

public protocol DataConvertibleProtocol {
    init?(data: Data)
    var data: Data { get }
}
