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
//  PhoneValidationRule.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 19/10/2021.
//

import Foundation
import PhoneNumberKit

struct PhoneValidationRule: ValidationRule {
    public var value: String
    public var countryCode: String

    public var field: ARConfigurations.Validation.Field = .mobile

    public init(phone: String = "", countryCode: String = "") {
        value = phone
        self.countryCode = countryCode
    }

    public func validate() throws {
        try validateIsEmpty()
        try validateMaximum()
        guard value.isNumeric == false else { throw ValidationError.cantContain(.letters, field.title) }
        do {
            _ = try PhoneNumberKit().parse(countryCode + value)
        } catch let error {
            throw ARErrorParser().parse(error)
        }
    }
}

extension PhoneValidationRule: IsMandatory {}
extension PhoneValidationRule: HasMaximum {}

extension String {
    var containsSymbols: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[^a-z0-9 ]", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) {
                return true
            } else {
                return false
            }
        } catch {
            LoggersManager.error(message: error.localizedDescription.tagWith(.internal))
            return true
        }
    }
}
