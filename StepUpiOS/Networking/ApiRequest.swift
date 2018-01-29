//
//  ApiRequest.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 20/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

open class ApiRequest<T: ApiRequestOptionsProtcol>:ApiRequestProtcol  {
    
    private let apiRequestOptions: T
    private var headers: [String: String] = [:]
    private var bodyData: [String: Any] = [:]
    
    private var sessionTask: URLSessionDataTask?
    private let completionBlock: ApiRequestCompletionBlock
    
    private var urlResponse: URLResponse?
    private var responseData: Data?
    
    public var requestMethod: RequestMethod = .get
    public var contentType: RequestContentType = .applicationJson
    
    public typealias ApiRequestCompletionBlock = (_ success: Bool, _ data: Any?, _ error: Error?) -> Void
    
    let url: String

    public init(url: String, options: T, completionBlock: @escaping ApiRequestCompletionBlock) {
        self.url = url
        self.completionBlock = completionBlock
        
        self.apiRequestOptions = options
        self.copyApiRequestOptions()
    }
    
    private func createUrlRequest() -> URLRequest {
        let url = URL(string: self.url, relativeTo: URL(string: "\(self.apiRequestOptions.protocolName)://\(self.apiRequestOptions.baseUrl)")!)!
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = self.requestMethod.rawValue
        
        for (header, value) in self.headers {
            urlRequest.addValue(value, forHTTPHeaderField: header)
        }
        
        switch self.contentType {
            case .applicationJson:
                urlRequest.setValue(self.contentType.rawValue, forHTTPHeaderField: "Content-Type")
                do {
                    if JSONSerialization.isValidJSONObject(self.bodyData), self.bodyData.count > 0 {
                        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: self.bodyData)
                    }
                } catch {
                }
            case .multiPartFormData:
                break
        }
        
        return urlRequest
    }
    
    public func start() {
        let urlRequest = createUrlRequest()
        
        sessionTask = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            self.responseData = data
            self.urlResponse = urlResponse
            
            if let error = error {
                Logger.error(message: "ApiRequest Error Detected", additionalData: ["Error": error, "Description": self.description()])
                self.completionBlock(false, data, error)
                return
            }

            guard let httpResponse = urlResponse as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    Logger.info(message: "Error Response Code Detected", additionalData: ["Description": self.description()])
                    self.completionBlock(false, data, error)
                    return
            }

            if let mimeType = httpResponse.mimeType, mimeType == "application/json",
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) {

                print(json)
                self.completionBlock(true, json, nil)
                return
            }

            Logger.error(message: "Unable to process mimeType: \(httpResponse.mimeType ?? "Unknown")", additionalData: ["Description": self.description()])
            
            self.completionBlock(false, nil, nil)
            return
        }
        
        sessionTask?.resume()
    }
    
    public func cancel() {
        sessionTask?.cancel()
    }
    
    internal func copyApiRequestOptions() {
        //  Copy Headers
        for (header, value) in self.apiRequestOptions.headers {
            addHeader(header, value: value)
        }
    }
    
    public func addHeader(_ name: String, value: String) {
        self.headers[name] = value
    }
    
    public func addBodyData(_ name: String, value: Any) {
        self.bodyData[name] = value
    }
    
    public func description() -> String {
        var description = "\n========== API REQUEST ==========\n"
        description += "URL:\t\t\(urlResponse?.url?.absoluteString ?? "URL Not Found")\n"
        description += "MimeType:\t\(urlResponse?.mimeType ?? "MimeType Not Found")\n"
        if let responseData = responseData, let data = String(data: responseData, encoding: .utf8) {
            description += "Body:\t\t\(data)\n"
        }
        description += "==============================\n"
        
        return description
    }
}
