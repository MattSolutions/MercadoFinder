//
//  Logger.swift
//  ProductFinder
//
//  Created by MATIAS BATTITI on 24/02/2025.
//

import Foundation

private enum LoggerLevel: String {
    case info = "[INFO]"
    case error = "[ERROR]"
}

private struct LoggerContext {
    
    let file: String
    let function: String
    let line: Int
    
    var description: String {
        return "🔹 \(file.split(separator: "/").last ?? " "): \(function) - Line: \(line)"
    }
}

struct Logger {
    
    static func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let logContext = LoggerContext(file: file, function: function, line: line)
        handleLog(level: .info, context: logContext, message: message)
    }
    
    static func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let logContext = LoggerContext(file: file, function: function, line: line)
        handleLog(level: .error, context: logContext, message: message)
    }
    
    private static func handleLog(level: LoggerLevel, context: LoggerContext, message: String) {
        let components = [level.rawValue, message, context.description]

        let fullString = components.joined(separator: " ")
        
        #if DEBUG
        print(fullString)
        #endif
    }
}
