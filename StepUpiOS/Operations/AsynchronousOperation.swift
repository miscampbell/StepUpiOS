//
//  AsynchronousOperation.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 08/07/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation
import CoreData

open class AsynchronousOperation: Operation
{
    override open var isAsynchronous: Bool { return true }
    override open var isExecuting: Bool { return state == .executing }
    override open var isFinished: Bool { return state == .finished }
    
    var state = State.ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }
    
    enum State: String {
        case ready = "Ready"
        case executing = "Executing"
        case finished = "Finished"
        fileprivate var keyPath: String { return "is" + self.rawValue }
    }
    
    override open func start() {
        Logger.debug(message: "Starting Operation \(String(describing: type(of: self)))")
        
        if self.isCancelled {
            state = .finished
        } else {
            state = .ready
            main()
        }
    }
    
    override open func main() {
        if self.isCancelled {
            state = .finished
        } else {
            state = .executing
            performAsynchronousOperation()
        }
    }
    
    open func performAsynchronousOperation()
    {
        Logger.error(message: "This method MUST be overridden implementing an Asynchronous Operation")
        fatalError("This method MUST be overridden implementing an Asynchronous Operation")
    }
    
    final public func asynchronousCompletionBlock(_ asyncBlock: (() -> Void)? ) {
        if self.isCancelled {
            state = .finished
            Logger.debug(message: "Cancelled Operation \(String(describing: type(of: self)))")
        } else {
            asyncBlock?()
            state = .finished
            Logger.debug(message: "Finished Operation \(String(describing: type(of: self)))")
        }
    }
}
