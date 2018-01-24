//
//  ApiRequestOptions.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 20/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

public struct ApiRequestOptions: ApiRequestOptionsProtcol {
    public var headers: [String : String]
    public var baseUrl: String
    public var protocolName: String
    
    public init(baseUrl: String, protocolName: String, headers: [String: String]) {
        self.baseUrl = baseUrl
        self.protocolName = protocolName
        self.headers = headers
    }
    
}
