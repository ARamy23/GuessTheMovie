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
//  AlamofireManager.swift
//  ARamy
//
//  Created by Ahmed Ramy on 11/11/2021.
//

import Foundation
import Alamofire
import Combine
import Pulse
import PhoneNumberKit

public final class AlamofireManager: NetworkProtocol {
    public let logger: NetworkLogger = .init()
    public typealias Percentage = Double
    public typealias Publisher = AnyPublisher<Percentage, Error>

    private typealias Subject = CurrentValueSubject<Percentage, Error>
    private var subjectsByTaskID = [UUID: Subject]()
    private lazy var session: Alamofire.Session = .init(eventMonitors: [ARAlamofireEventsMonitor(logger: logger)])

    private var cancellables = Set<AnyCancellable>()

    public func call<T: Codable, U: Endpoint>(api: U, model: T.Type) -> ARResponse<T> {
        let subject = PassthroughSubject<T, ARError>()
        session.request(
            api.baseURL + api.path,
            method: api.method.toAlamofireFriendly(),
            parameters: api.parameters,
            encoding: api.encoding.toAlamofireFriendly(),
            headers: api.headers.toAlamofireFriendly()
        ).responseData { response in
            var result: Result<Data, Error>
            if let data = response.data {
                result = .success(data)
            } else if let error = response.error {
                result = .failure(error)
            } else {
                result = .failure(ARError.somethingWentWrong)
            }

            switch result {
            case let .success(data):
                if response.response?.isSuccess ?? false, let model = SuccessParser().parse(data, expectedType: model) {
                    subject.send(model)
                } else {
                    subject.send(completion: .failure(ARErrorParser().parse(data)))
                }
            case let .failure(error):
                subject.send(completion: .failure(error.asARError()))
            }
        }

        return subject.eraseToAnyPublisher()
    }

    public func upload<T: Codable, U: Endpoint>(api: U, model: T.Type) -> ARResponseWithProgress<T> {
        let subject = PassthroughSubject<ARProgressResponse<T>, ARError>()
        let request = session.upload(
            multipartFormData:
            ParametersToMultipartFormDataAdapter()
                .adapt(api.parameters),
            to: api.baseURL + api.path
        ).uploadProgress { progress in
            let totalBytesSent = progress.totalUnitCount
            let totalBytesExpectedToSend = progress.completedUnitCount
            debugPrint(progress)
            subject.send(.loading(Double(totalBytesSent) / Double(totalBytesExpectedToSend)))
        }

        enqueueTaskForProgressObservation(request.id)

        request.responseData { response in
            var result: Result<Data, Error>
            if let data = response.data {
                result = .success(data)
            } else if let error = response.error {
                result = .failure(error)
            } else {
                result = .failure(ARError.somethingWentWrong)
            }

            switch result {
            case let .success(data):
                if let model = SuccessParser().parse(data, expectedType: model) {
                    subject.send(.finished(model))
                    subject.send(completion: .finished)
                } else {
                    subject.send(completion: .failure(ARErrorParser().parse(data)))
                }
            case let .failure(error):
                subject.send(completion: .failure(error.asARError()))
            }
        }

        subscribe(to: request.id)?
            .sink(receiveCompletion: { [weak self] _ in
                self?.dequeueTaskFromProgressObservation(request.id)
            }, receiveValue: { percentage in
                subject.send(.loading(percentage))
            }).store(in: &cancellables)

        return subject.eraseToAnyPublisher()
    }

    private func enqueueTaskForProgressObservation(_ id: UUID) {
        subjectsByTaskID[id] = .init(0)
    }

    private func dequeueTaskFromProgressObservation(_ id: UUID) {
        subjectsByTaskID.removeValue(forKey: id)
    }

    private func subscribe(to id: UUID) -> Publisher? {
        subjectsByTaskID[id]?.eraseToAnyPublisher()
    }
}

public struct SuccessParser {
    func parse<T: Codable>(_ data: Data, expectedType: T.Type) -> T? {
        data.decode(expectedType)
    }
}

public struct ARErrorParser {
    func parse(_ error: Error) -> ARError {
        switch error {
        case let urlError as URLError:
            return NetworkErrorToARErrorAdapter().adapt(urlError)
//        case let googleSignInError as GIDSignInError:
//            return GIDSignInErrorToARErrorAdapter().adapt(googleSignInError)
//        case let appleSignInError as ASAuthorizationError:
//            return ASAuthorizationErrorToARError().adapt(appleSignInError)
        case let phoneNumberError as PhoneNumberError:
            return PhoneNumberErrorToARErrorAdapter().adapt(phoneNumberError)
        // TODO: - Add Facebook
        case let validationError as ValidationError:
            return .init(validation: validationError)
        default:
            return error as? ARError ?? .init(code: nil, text: error.localizedDescription)
        }
    }

    func parse(_ data: Data) -> ARError {
        guard let response = data.decode(ErrorResponse.self) else { return .somethingWentWrong }
        if let error = response.errors?.first {
            return error
        } else {
            switch response.statusCode {
            case 400:
                LoggersManager
                    .error(
                        message: "Bad Request Error\nDetails: \(response)".tagWith([.network])
                    )
            case 500:
                LoggersManager.error(
                    message: "Server Error\nDetails: \(response)".tagWith([.network])
                )
            default:
                LoggersManager.info(
                    message: "Response came with a strange unhandled status code\nDetails: \(response)".tagWith([.network])
                )
            }

            return .somethingWentWrong
        }
    }
}

extension ARamy.HTTPMethod {
    func toAlamofireFriendly() -> Alamofire.HTTPMethod {
        switch self {
        case .GET:
            return .get
        case .POST:
            return .post
        }
    }
}

extension ARamy.ParametersEncoding {
    func toAlamofireFriendly() -> Alamofire.ParameterEncoding {
        switch self {
        case .urlEncoding:
            return URLEncoding.default
        case .jsonEncoding:
            return JSONEncoding.default
        case .multipartEncoding:
            return JSONEncoding.default
        }
    }
}

extension ARamy.HTTPHeaders {
    func toAlamofireFriendly() -> Alamofire.HTTPHeaders {
        .init(map { key, value in
            HTTPHeader(name: key, value: value)
        })
    }
}

extension HTTPURLResponse {
    var isSuccess: Bool {
        switch statusCode {
        case 200 ... 399:
            return true
        default:
            return false
        }
    }
}
