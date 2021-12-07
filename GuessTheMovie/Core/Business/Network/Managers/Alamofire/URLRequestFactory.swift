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
//  URLRequestFactory.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/11/2021.
//

import Foundation

public enum URLRequestFactory {
    /// Generates URLRequest after building the URL, injecting the method and the headers
    /// and encoding the Parameters suitably according to the endpoint
    /// - Parameter endpoint: the protocol that carries the details of the request
    /// - Returns: URLRequest for the manager to use
    public static func generateRequest(outOf endpoint: Endpoint) -> URLRequest {
        let url = generateURL(outOf: endpoint)
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = endpoint.method.rawValue

        endpoint.headers.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        encodeRequestWithParameters(&urlRequest, from: endpoint)

        return urlRequest
    }
}

private extension URLRequestFactory {
    /// Generates URL out of endpoint protocol
    /// - Parameter endpoint: the protocol that carries the details of the request
    /// - Returns: the URL to be used to build the URLRequest
    private static func generateURL(outOf endpoint: Endpoint) -> URL {
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            // We used a fatalError here with a helpful message so that if we had a
            // typo in the path or the baseURL, this fatalError notifies us, Normally
            // i'd go for an assertionFailure so it doesn't crash the app in
            // production, but since am sure this won't happen in production but only
            // in development, so I don't see anything wrong with it
            fatalError("You probably passed a wrong URL,\n check \(endpoint.baseURL) or \(endpoint.path)")
        }
        return url
    }

    /// Encodes the parameters in the URL
    private static func encodeParametersInURL(in urlRequest: inout URLRequest, endpoint: Endpoint) {
        guard let url = urlRequest.url?.absoluteString else { return }
        guard var urlComponents = URLComponents(string: url) else { return }
        urlComponents.queryItems = endpoint.parameters.map { key, value in
            URLQueryItem(name: key, value: value as? String ?? "")
        }

        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

        urlRequest.url = urlComponents.url
    }

    /// Encodes the parameters in the Request Body
    private static func encodeParametersInBodyOfRequest(in request: inout URLRequest, endpoint: Endpoint) {
        do {
            let data = try JSONSerialization.data(withJSONObject: endpoint.parameters, options: [])
            request.httpBody = data
        } catch {
            LoggersManager.error(error.asARError())
        }
    }

    /// Handles How the parameters will be encoded according to the endpoint encoding
    private static func encodeRequestWithParameters(_ request: inout URLRequest, from endpoint: Endpoint) {
        switch endpoint.encoding {
        case .urlEncoding:
            encodeParametersInURL(in: &request, endpoint: endpoint)
        case .jsonEncoding:
            encodeParametersInBodyOfRequest(in: &request, endpoint: endpoint)
        case .multipartEncoding:
            // Note: This is handled by Alamofire
            break
        }
    }
}
