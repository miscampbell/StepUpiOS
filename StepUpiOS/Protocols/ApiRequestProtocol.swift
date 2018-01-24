//
//  ApiRequestProtocol.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 20/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

public protocol ApiRequestProtcol {
    func start()
    func cancel()
    
    func addHeader(_ name: String, value: String)
    var requestMethod: RequestMethod { get }
    var contentType: RequestContentType { get }
}

public protocol ApiRequestOptionsProtcol {
    var protocolName: String { get }
    var baseUrl: String { get }
    
    var headers: [String: String] { get }
}

public enum RequestMethod: String {
    case get = "GET"
    case delete = "DELETE"
    case post = "POST"
    case put = "PUT"
}

public enum RequestContentType: String {
    case multiPartFormData = "multipart/form-data; boundary="
    case applicationJson = "application/json"
}
