//
//  Logger.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/28/23.
//

import Foundation
protocol LogQuery {
    static func log(type: LogType?, msg: String)
    static func log(msg: String)
}
enum LogType {
    static var `default`: LogType { return .info }
    case warn
    case error
    case success
    case info
    case ui
    var description: String {
        return "\(self)".uppercased()
    }
}
struct Logger: LogQuery {
    static func log(msg: String) {
        #if DEBUG
        debugPrint(msg)
        #endif
    }
    static func log(type: LogType?, msg: String) {
        let typeofLog = type ?? .info
        #if DEBUG
        debugPrint("\(typeofLog.description): \(msg)")
        #endif
    }
}
