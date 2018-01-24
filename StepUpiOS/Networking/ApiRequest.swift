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
            if let error = error {
                print(error)
                self.completionBlock(false, data, error)
                return
            }

            guard let httpResponse = urlResponse as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print(String(data: data!, encoding: .utf8))
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

            self.completionBlock(false, nil, nil)
            return
        }
        
        sessionTask?.resume()
    }
    
    public func cancel() {
        
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
}
