//
//  HTTPNetworking.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 10/01/2019.
//  Copyright © 2019 Michael Miscampbell. All rights reserved.
//

import Foundation

struct HTTPNetworking: Networking {
    func request(from: Endpoint, completion: @escaping CompletionHandler) {
        guard let url = URL(string: from.path) else {
            return
        }
        
        let request = createUrlRequest(from: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createUrlRequest(from url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        return request
    }
    
    private func createDataTask(from: URLRequest, completion: @escaping CompletionHandler) -> URLSessionTask {
        return URLSession.shared.dataTask(with: from, completionHandler: { (data, httpResponse, error) in
            completion(data, error)
        })
    }
}
