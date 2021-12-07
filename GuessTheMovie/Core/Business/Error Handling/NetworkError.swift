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
//  NetworkError.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 12/11/2021.
//

import Foundation

// swiftlint:disable identifier_name
// swiftlint:disable nesting

/// `NetworkError` is the error type returned by Alamofire. It encompasses a few different types of errors, each with
/// their own associated reasons.
public enum NetworkError: Error {
    /// The underlying reason the `.multipartEncodingFailed` error occurred.
    public enum MultipartEncodingFailureReason {
        /// The `fileURL` provided for reading an encodable body part isn't a file `URL`.
        case bodyPartURLInvalid(url: URL)
        /// The filename of the `fileURL` provided has either an empty `lastPathComponent` or `pathExtension.
        case bodyPartFilenameInvalid(in: URL)
        /// The file at the `fileURL` provided was not reachable.
        case bodyPartFileNotReachable(at: URL)
        /// Attempting to check the reachability of the `fileURL` provided threw an error.
        case bodyPartFileNotReachableWithError(atURL: URL, error: Error)
        /// The file at the `fileURL` provided is actually a directory.
        case bodyPartFileIsDirectory(at: URL)
        /// The size of the file at the `fileURL` provided was not returned by the system.
        case bodyPartFileSizeNotAvailable(at: URL)
        /// The attempt to find the size of the file at the `fileURL` provided threw an error.
        case bodyPartFileSizeQueryFailedWithError(forURL: URL, error: Error)
        /// An `InputStream` could not be created for the provided `fileURL`.
        case bodyPartInputStreamCreationFailed(for: URL)
        /// An `OutputStream` could not be created when attempting to write the encoded data to disk.
        case outputStreamCreationFailed(for: URL)
        /// The encoded body data could not be written to disk because a file already exists at the provided `fileURL`.
        case outputStreamFileAlreadyExists(at: URL)
        /// The `fileURL` provided for writing the encoded body data to disk is not a file `URL`.
        case outputStreamURLInvalid(url: URL)
        /// The attempt to write the encoded body data to disk failed with an underlying error.
        case outputStreamWriteFailed(error: Error)
        /// The attempt to read an encoded body part `InputStream` failed with underlying system error.
        case inputStreamReadFailed(error: Error)
    }

    /// Represents unexpected input stream length that occur when encoding the `MultipartFormData`. Instances will be
    /// embedded within an `NetworkError.multipartEncodingFailed` `.inputStreamReadFailed` case.
    public struct UnexpectedInputStreamLength: Error {
        /// The expected byte count to read.
        public var bytesExpected: UInt64
        /// The actual byte count read.
        public var bytesRead: UInt64
    }

    /// The underlying reason the `.parameterEncodingFailed` error occurred.
    public enum ParameterEncodingFailureReason {
        /// The `URLRequest` did not have a `URL` to encode.
        case missingURL
        /// JSON serialization failed with an underlying system error during the encoding process.
        case jsonEncodingFailed(error: Error)
        /// Custom parameter encoding failed due to the associated `Error`.
        case customEncodingFailed(error: Error)
    }

    /// The underlying reason the `.parameterEncoderFailed` error occurred.
    public enum ParameterEncoderFailureReason {
        /// Possible missing components.
        public enum RequiredComponent {
            /// The `URL` was missing or unable to be extracted from the passed `URLRequest` or during encoding.
            case url
            /// The `HTTPMethod` could not be extracted from the passed `URLRequest`.
            case httpMethod(rawValue: String)
        }

        /// A `RequiredComponent` was missing during encoding.
        case missingRequiredComponent(RequiredComponent)
        /// The underlying encoder failed with the associated error.
        case encoderFailed(error: Error)
    }

    /// The underlying reason the `.responseValidationFailed` error occurred.
    public enum ResponseValidationFailureReason {
        /// The data file containing the server response did not exist.
        case dataFileNil
        /// The data file containing the server response at the associated `URL` could not be read.
        case dataFileReadFailed(at: URL)
        /// The response did not contain a `Content-Type` and the `acceptableContentTypes` provided did not contain a
        /// wildcard type.
        case missingContentType(acceptableContentTypes: [String])
        /// The response `Content-Type` did not match any type in the provided `acceptableContentTypes`.
        case unacceptableContentType(acceptableContentTypes: [String], responseContentType: String)
        /// The response status code was not acceptable.
        case unacceptableStatusCode(code: Int)
        /// Custom response validation failed due to the associated `Error`.
        case customValidationFailed(error: Error)
    }

    /// The underlying reason the response serialization error occurred.
    public enum ResponseSerializationFailureReason {
        /// The server response contained no data or the data was zero length.
        case inputDataNilOrZeroLength
        /// The file containing the server response did not exist.
        case inputFileNil
        /// The file containing the server response could not be read from the associated `URL`.
        case inputFileReadFailed(at: URL)
        /// String serialization failed using the provided `String.Encoding`.
        case stringSerializationFailed(encoding: String.Encoding)
        /// JSON serialization failed with an underlying system error.
        case jsonSerializationFailed(error: Error)
        /// A `DataDecoder` failed to decode the response due to the associated `Error`.
        case decodingFailed(error: Error)
        /// A custom response serializer failed due to the associated `Error`.
        case customSerializationFailed(error: Error)
        /// Generic serialization failed for an empty response that wasn't type `Empty` but instead the associated type.
        case invalidEmptyResponse(type: String)
    }

    #if !(os(Linux) || os(Windows))
        /// Underlying reason a server trust evaluation error occurred.
        public enum ServerTrustFailureReason {
            /// The output of a server trust evaluation.
            public struct Output {
                /// The host for which the evaluation was performed.
                public let host: String
                /// The `SecTrust` value which was evaluated.
                public let trust: SecTrust
                /// The `OSStatus` of evaluation operation.
                public let status: OSStatus
                /// The result of the evaluation operation.
                public let result: SecTrustResultType

                /// Creates an `Output` value from the provided values.
                init(_ host: String, _ trust: SecTrust, _ status: OSStatus, _ result: SecTrustResultType) {
                    self.host = host
                    self.trust = trust
                    self.status = status
                    self.result = result
                }
            }

            /// No `ServerTrustEvaluator` was found for the associated host.
            case noRequiredEvaluator(host: String)
            /// No certificates were found with which to perform the trust evaluation.
            case noCertificatesFound
            /// No public keys were found with which to perform the trust evaluation.
            case noPublicKeysFound
            /// During evaluation, application of the associated `SecPolicy` failed.
            case policyApplicationFailed(trust: SecTrust, policy: SecPolicy, status: OSStatus)
            /// During evaluation, setting the associated anchor certificates failed.
            case settingAnchorCertificatesFailed(status: OSStatus, certificates: [SecCertificate])
            /// During evaluation, creation of the revocation policy failed.
            case revocationPolicyCreationFailed
            /// `SecTrust` evaluation failed with the associated `Error`, if one was produced.
            case trustEvaluationFailed(error: Error?)
            /// Default evaluation failed with the associated `Output`.
            case defaultEvaluationFailed(output: Output)
            /// Host validation failed with the associated `Output`.
            case hostValidationFailed(output: Output)
            /// Certificate pinning failed.
            case certificatePinningFailed(host: String, trust: SecTrust, pinnedCertificates: [SecCertificate], serverCertificates: [SecCertificate])
            /// Public key pinning failed.
            case publicKeyPinningFailed(host: String, trust: SecTrust, pinnedKeys: [SecKey], serverKeys: [SecKey])
            /// Custom server trust evaluation failed due to the associated `Error`.
            case customEvaluationFailed(error: Error)
        }
    #endif

    /// The underlying reason the `.urlRequestValidationFailed`
    public enum URLRequestValidationFailureReason {
        /// URLRequest with GET method had body data.
        case bodyDataInGETRequest(Data)
    }

    ///  `UploadableConvertible` threw an error in `createUploadable()`.
    case createUploadableFailed(error: Error)
    ///  `URLRequestConvertible` threw an error in `asURLRequest()`.
    case createURLRequestFailed(error: Error)
    /// `SessionDelegate` threw an error while attempting to move downloaded file to destination URL.
    case downloadedFileMoveFailed(error: Error, source: URL, destination: URL)
    /// `Request` was explicitly cancelled.
    case explicitlyCancelled
    /// Multipart form encoding failed.
    case multipartEncodingFailed(reason: MultipartEncodingFailureReason)
    /// `ParameterEncoding` threw an error during the encoding process.
    case parameterEncodingFailed(reason: ParameterEncodingFailureReason)
    /// `ParameterEncoder` threw an error while running the encoder.
    case parameterEncoderFailed(reason: ParameterEncoderFailureReason)
    /// `RequestAdapter` threw an error during adaptation.
    case requestAdaptationFailed(error: Error)
    /// `RequestRetrier` threw an error during the request retry process.
    case requestRetryFailed(retryError: Error, originalError: Error)
    /// Response validation failed.
    case responseValidationFailed(reason: ResponseValidationFailureReason)
    /// Response serialization failed.
    case responseSerializationFailed(reason: ResponseSerializationFailureReason)
    #if !(os(Linux) || os(Windows))
        /// `ServerTrustEvaluating` instance threw an error during trust evaluation.
        case serverTrustEvaluationFailed(reason: ServerTrustFailureReason)
    #endif
    /// `Session` which issued the `Request` was deinitialized, most likely because its reference went out of scope.
    case sessionDeinitialized
    /// `Session` was explicitly invalidated, possibly with the `Error` produced by the underlying `URLSession`.
    case sessionInvalidated(error: Error?)
    /// `URLSessionTask` completed with error.
    case sessionTaskFailed(error: Error)
    /// `URLRequest` failed validation.
    case urlRequestValidationFailed(reason: URLRequestValidationFailureReason)
}
