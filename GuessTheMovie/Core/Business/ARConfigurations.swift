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
//  ARConfigurations.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 15/11/2021.
//

import Foundation

/// Represents Business Logic Configuration for easier changes whether global or specific changes
public enum ARConfigurations {
    public enum Validation {}

    public enum Video {
        static let maxDurationInSeconds: Double = 20.0
    }
}

public extension ARConfigurations.Validation {
    enum Field {
        case username
        case firstName
        case lastName
        case mobile
        case email
        case password
        case confirmPassword
        case countryCode

        var minMax: (min: Int, max: Int) {
            switch self {
            case .username:
                return (3, 20)
            case .firstName:
                return (2, 10)
            case .lastName:
                return (2, 10)
            case .mobile:
                return (0, 15)
            case .email:
                return (0, 999)
            case .password,
                 .confirmPassword:
                return (5, 32)
            case .countryCode:
                return (1, 3)
            }
        }

        var title: String {
            switch self {
            case .username:
                return L10n.validationFieldNameUsername
            case .firstName:
                return L10n.validationFieldNameFirstname
            case .lastName:
                return L10n.validationFieldNameLastname
            case .mobile:
                return L10n.validationFieldNameMobile
            case .email:
                return L10n.validationFieldNameEmail
            case .password:
                return L10n.validationFieldNamePassword
            case .confirmPassword:
                return L10n.validationFieldNameConfirmPassword
            case .countryCode:
                return L10n.validationFieldNameCountryCode
            }
        }
    }
}
