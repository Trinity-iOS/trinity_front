//
//  Logger.swift
//  Trinity
//
//  Created by Park Seyoung on 1/19/25.
//

import Foundation

enum LogLevel: String {
    case info = "ℹ️"
    case network = "🌐"
    case warning = "⚠️"
    case debug = "✅"
    case error = "❌"
}

func log(_ message: String, level: LogLevel = .info, file: String = #file, function: String = #function, line: Int = #line) {
    let fileName = (file as NSString).lastPathComponent
    print("\(level.rawValue) [\(fileName):\(line) - \(function)] \(message)")
}
