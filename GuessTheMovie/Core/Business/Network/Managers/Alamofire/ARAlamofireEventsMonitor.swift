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
//  ARAlamofireEventsMonitor.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/11/2021.
//

import Alamofire
import Foundation
import Logging
import Pulse

public struct ARAlamofireEventsMonitor: EventMonitor {
    let logger: NetworkLogger

    public func requestDidResume(_ request: Request) {
        let body = request
            .request
            .flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } }
            ?? "No Request Body to Log"

        let headers = (request.request?.headers ?? [])
            .map { "----\($0.name): \($0.value)" }
            .joined(separator: "\n")

        let url = request.request?.url?.absoluteString ?? ""

        let method = request.request?.httpMethod ?? ""

        let message = """
        ⚡️🚀===[Request Start]===
        ⚡️🚀 Method: \(method)
        ⚡️🚀 URL: \(url)
        ⚡️🚀 Body: \(body)
        ⚡️🚀 Headers: \(headers)
        ⚡️🚀===[Request End]===
        """
        SystemLogger.main.info(message: message)
    }

    public func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        let body = String(decoding: response.data ?? Data(), as: UTF8.self)

        let headers = (request.response?.headers ?? [])
            .map { "----\($0.name): \($0.value)" }
            .joined(separator: "\n")

        let url = request.response?.url?.absoluteString ?? ""
        let method = request.request?.httpMethod ?? ""
        let status = response.response?.statusCode ?? -1

        let message = """
        ⚡️✨===[Response Start]===
        ⚡️✨ Method: \(method)
        ⚡️✨ URL: \(url)
        ⚡️✨ Status Code: \(status)
        ⚡️✨ Body: \(body)
        ⚡️✨ Headers: \(headers)
        ⚡️✨===[Response Start]===
        """
        SystemLogger.main.info(message: message)
    }

    public func request(_: Request, didCreateTask task: URLSessionTask) {
        logger.logTaskCreated(task)
    }

    public func urlSession(_: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        logger.logDataTask(dataTask, didReceive: data)
    }

    public func urlSession(_: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        logger.logTask(task, didFinishCollecting: metrics)
    }

    public func urlSession(_: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        logger.logTask(task, didCompleteWithError: error)
    }
}
