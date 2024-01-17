//
//  Logger.swift
//  SwiftUI Experiments
//
//  Created by Mykhailo on 1/7/24.
//

struct Logger {
    static func info<T>(caller: T, msg: String) {
        printMessage(prefix: "I", caller: caller, msg: msg)
    }
    
    static func error<T>(caller: T, msg: String) {
        printMessage(prefix: "E", caller: caller, msg: msg)
    }
    
    // MARK: - Intenals
    private static func printMessage<T>(prefix: String, caller: T, msg: String) {
        #if DEBUG
        let tag = formatCallerTag(caller: caller)
        print("\(prefix) [\(tag)]: \(msg)")
        #endif
    }
    
    private static func formatCallerTag<T>(caller: T) -> String {
        return String("\(caller)".split(separator: ".").last ?? "")
    }
}
