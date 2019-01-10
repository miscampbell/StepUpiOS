//
//  Networking.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 10/01/2019.
//  Copyright © 2019 Michael Miscampbell. All rights reserved.
//

import Foundation

protocol Networking {
    typealias CompletionHandler = (Data?, Swift.Error?) -> Void
    
    func request(from: Endpoint, completion: @escaping CompletionHandler)
}

protocol Endpoint {
    var path: String { get }
    var method: String { get }
}

