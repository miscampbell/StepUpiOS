//
//  DataConvertibleProtocolExtension.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 10/02/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

public extension DataConvertibleProtocol {
    public init?(data: Data) {
        guard data.count == MemoryLayout<Self>.size else { return nil }
        self = data.withUnsafeBytes { $0.pointee }
    }
    
    public var data: Data {
        var value = self
        return Data(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }
}

extension Int : DataConvertibleProtocol { }
extension Float : DataConvertibleProtocol { }
extension Double : DataConvertibleProtocol { }
