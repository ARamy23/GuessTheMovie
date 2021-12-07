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
//  GIDSignInErrorToARErrorAdapter.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 16/11/2021.
//

import Foundation
//import GoogleSignIn
//
//public struct GIDSignInErrorToARErrorAdapter: AdapterProtocol {
//    typealias Input = GIDSignInError
//    typealias Output = ARError
//
//    func adapt(_ error: GIDSignInError) -> ARError {
//        switch error._nsError.code {
//        /// Indicates an unknown error has occurred.
//        case -1:
//            return .somethingWentWrong
//        /// Indicates a problem reading or writing to the application keychain.
//        case -2:
//            return .somethingWentWrong
//        /// Indicates there are no valid auth tokens in the keychain. This error code will be returned by
//        /// `restorePreviousSignIn` if the user has not signed in before or if they have since signed out.
//        case -4:
//            return .refreshTokenExpired
//        /// Indicates the user canceled the sign in request.
//        case -5:
//            return .requestCancelled
//        /// Indicates an Enterprise Mobility Management related error has occurred.
//        case -6:
//            return .somethingWentWrong
//        /// Indicates there is no `currentUser`.
//        case -7:
//            return .refreshTokenExpired
//        /// Indicates the requested scopes have already been granted to the `currentUser`.
//        case -8:
//            return .somethingWentWrong
//        default:
//            return .somethingWentWrong
//        }
//    }
//}
