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
//  ARError.swift
//  RamySDK
//
//  Created by michelle gergs on 13/09/2021.
//

import UIKit

public struct ARError: Error, Codable, Equatable {
    var code: ErrorCode?
    private var _text: String?
    var text: String? {
        get {
            code?.message ?? _text
        }

        set {
            _text = newValue
        }
    }

    init(code: ErrorCode?, text: String?) {
        self.code = code
        _text = text
    }

    init(validation: ValidationError) {
        code = nil
        _text = validation.localizedDescription
    }

    public static func == (lhs: ARError, rhs: ARError) -> Bool {
        lhs.code == rhs.code &&
            lhs._text == rhs._text
    }
}

extension ARError {
    static var somethingWentWrong: ARError {
        ARError(code: nil, text: L10n.someThingWentWrong)
    }

    static var requestCancelled: ARError {
        ARError(code: .requestCancelled, text: "")
    }

    // TODO: - [Future] Localize -
    static var refreshTokenExpired: ARError {
        ARError(code: .refreshTokenExpired, text: "You must log in again...")
    }

    // TODO: - [Future] Localize -
    static var noNetworkOrTooWeak: ARError {
        ARError(code: .noNetworkOrTooWeak, text: "We can't detect a network, either because it's too weak or it's non-existent, most probably the signal?")
    }

    static var tokenExpired: ARError {
        ARError(code: .tokenExpired, text: "")
    }
}

public enum ErrorCode: String, Codable {
    case usernameAlreadyExist = "E0004"
    case emailAlreadyExist = "E0011"
    case userNameDoesntExist = "E0001"
    case emailAndPasswordDoesntMatch = "E0015"
    case userIsNotVerified = "E0022"
    case phoneAlreadyExist = "E0014"
    case emailNotValid = "E0009"
    case tokenExpired = "E00401"
    case invalidVerifyLinkToken = "E0024"
    case userAlreadyVerified = "E0023"
    case refreshTokenExpired = "E00401X"
    case requestCancelled = "Cancelled"
    case noNetworkOrTooWeak = "No Network"

    var message: String? {
        switch self {
        case .userIsNotVerified:
            return L10n.emailNeedVerification
        case .emailAlreadyExist:
            return L10n.emailAlreadyExists
        case .phoneAlreadyExist:
            return L10n.phoneAlreadyExists
        case .usernameAlreadyExist:
            return L10n.usernameAlreadyExists
        case .userNameDoesntExist:
            return L10n.userNameDoesntExists
        case .emailNotValid:
            return L10n.emailNotValid
        case .emailAndPasswordDoesntMatch:
            return L10n.authErrorMessageEmailAndPasswordDoesntMatch
        case .userAlreadyVerified:
            return L10n.authErrorMessageYouAreAlreadyVerified
        default:
            return nil
        }
    }

    var isPresentable: Bool {
        switch self {
        case .requestCancelled,
             .tokenExpired:
            return false
        default:
            return true
        }
    }

    var loggable: Bool {
        loggingChannels.isEmpty == false
    }

    var loggingChannels: [LogEngine] {
        switch self {
        case .requestCancelled:
            return []
        default:
            return .all
        }
    }
}

extension Error {
    func asARError() -> ARError {
        ARErrorParser().parse(self)
    }
}
