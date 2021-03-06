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
//  Endpoint.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/11/2021.
//

import Alamofire

public typealias HTTPHeaders = [String: String]
public typealias HTTPParameters = [String: Any]

/// A protocol that carries the request details for the network manager to use
///
///
/// We are encapsulating the logic of our APIs behind a protocol called Endpoint
/// this endpoint can be anything
/// it can be our own Endpoint enum that follows the same concept of Moya's TargetType
/// and we can also use it with any Networking Pod like Alamofire or Moya through
/// an adapter pattern if needed
public protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
    var parameters: HTTPParameters { get }
    var encoding: ParametersEncoding { get }
    var method: HTTPMethod { get }
}

public extension Endpoint {
    /// Base URL for calling endpoints which is configurable according to Build
    /// Configurations
    var baseURL: String {
        #if DEBUG
            return "https://gist.githubusercontent.com/i0sa/f5b878c5a35386fda952c350fc53fce9/raw/186811752752d29fbf5ee5418065daa689593ff5/"
        #elseif STAGING
            return "https://api.dev.RamySDK.tech/m/"
        #elseif RELEASE
            return "https://api.RamySDK.tech/m/"
        #endif
    }

    var headers: HTTPHeaders {
        defaultHeaders()
    }

    /// Defaults to JSONEncoding in case of POST, and URLEncoding GET
    /// Also Overridable in children in case of Composite Encoding or Irregular cases from the BE
    var encoding: ParametersEncoding {
        switch method {
        case .POST:
            return .jsonEncoding
        case .GET:
            return .urlEncoding
        }
    }

    func defaultHeaders() -> HTTPHeaders {
        var headers = [
            "Accept-Language": "en",
            "Accept": "application/json",
            "Content-Type": "application/json",
        ]

//        if let token = UserService.main.user.value.authorizationInfo?.token {
//            headers["Authorization"] = token
//        }

        return headers
    }
}

/// Determines how the network manager will encode the parameters when firing the
/// request
public enum ParametersEncoding {
    /// Encodes the parameters as url query parameters
    case urlEncoding
    /// Encodes the parameters in the body of the request
    case jsonEncoding
    /// Encodes the parameters as a multipart form data and file data
    case multipartEncoding
}

/// HTTPMethods enum in String to ease generating Request and avoid switching and enjoy syntactic sugar
public enum HTTPMethod: String {
    case GET
    case POST
}
