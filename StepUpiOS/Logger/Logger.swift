//
//  Logger.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 27/01/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation

public class Logger {
    private enum LogType:String {
        case error = "[‼️]" // error
        case info = "[ℹ️]" // info
        case debug = "[💬]" // debug
        case verbose = "[🔬]" // verbose
        case warning = "[⚠️]" // warning
        case severe = "[🔥]" // severe
    }
    
    private static func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
    private static func log(message: String, additionalData: [String: Any], logType: LogType, fileName: String, line: Int, column: Int, funcName: String)
    {
        #if DEBUG
            var additionalDataString = ""
            if additionalData.count > 0 {
                additionalDataString = "\nAdditional Data:\n"
                for (key, data) in additionalData {
                    additionalDataString += "\(key): \(data)\n"
                }
            }
            print("\(Formatter.logger.string(from: Date())) \(logType.rawValue)[\(sourceFileName(filePath: fileName))]:\(line) \(column) \(funcName) -> \(message)\(additionalDataString)")
        #endif
    }
    
    public static func error(message: String, additionalData: [String: Any] = [:], fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        log(message: message, additionalData: additionalData, logType: .error, fileName: fileName, line: line, column: column, funcName: funcName)
    }
    
    public static func info(message: String, additionalData: [String: Any] = [:], fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        log(message: message, additionalData: additionalData, logType: .info, fileName: fileName, line: line, column: column, funcName: funcName)
    }
    
    public static func debug(message: String, additionalData: [String: Any] = [:], fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        log(message: message, additionalData: additionalData, logType: .debug, fileName: fileName, line: line, column: column, funcName: funcName)
    }
    
    public static func verbose(message: String, additionalData: [String: Any] = [:], fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        log(message: message, additionalData: additionalData, logType: .verbose, fileName: fileName, line: line, column: column, funcName: funcName)
    }
    
    public static func warning(message: String, additionalData: [String: Any] = [:], fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        log(message: message, additionalData: additionalData, logType: .warning, fileName: fileName, line: line, column: column, funcName: funcName)
    }
    
    public static func severe(message: String, additionalData: [String: Any] = [:], fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        log(message: message, additionalData: additionalData, logType: .severe, fileName: fileName, line: line, column: column, funcName: funcName)
    }
}
