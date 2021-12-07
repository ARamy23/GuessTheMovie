//
// This is free and unencumbered software released into the public domain.
// 
// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.
//
// In jurisdictions that recognize copyright laws, the author or authors
// of this software dedicate any and all copyright interest in the
// software to the public domain. We make this dedication for the benefit
// of the public at large and to the detriment of our heirs and
// successors. We intend this dedication to be an overt act of
// relinquishment in perpetuity of all present and future rights to this
// software under copyright law.
// 
// THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
// 
// For more information, please refer to <https://unlicense.org>
//
//
//  LoggersManager.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 23/10/2021.
//

import Foundation

public enum LoggersManager {
    private static var engines: [LogEngine] {
        .all
    }

    public static func info(message: String) {
        engines.forEach { $0.info(message: message) }
    }

    public static func warn(message: String) {
        engines.forEach { $0.warn(message: message) }
    }

    public static func error(message: String) {
        engines.forEach { $0.error(message: message) }
    }

    public static func info(_ error: ARError) {
        guard error.code?.loggable ?? true == true else { return }
        engines.forEach { $0.info(message: "\(error)") }
    }

    public static func warn(_ error: ARError) {
        guard error.code?.loggable ?? true == true else { return }
        engines.forEach { $0.warn(message: "\(error)") }
    }

    public static func error(_ error: ARError) {
        guard error.code?.loggable ?? true == true else { return }
        engines.forEach { $0.error(message: "\(error)") }
    }
}

public extension String {
    func tagWith(_ tag: LogTag) -> String {
        withPrefix("\(tag.rawValue) ")
    }

    func tagWith(_ tags: [LogTag]) -> String {
        tags.map { "[\($0.rawValue)]" }.joined(separator: "").withPrefix(" \(self)")
    }

    func withPrefix(_ prefix: String) -> String {
        "\(prefix)\(self)"
    }
}
