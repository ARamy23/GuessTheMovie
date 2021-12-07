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
//  ValidationRule.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 18/10/2021.
//

import Foundation

public protocol ValidationRule {
    var value: String { get set }
    func validate() throws
}

public protocol IsMandatory {
    var field: ARConfigurations.Validation.Field { get }
    func validateIsEmpty() throws
}

public protocol HasMinimum {
    var field: ARConfigurations.Validation.Field { get }
    func validateMinimum() throws
}

public protocol HasMaximum {
    var field: ARConfigurations.Validation.Field { get }
    func validateMaximum() throws
}

public extension HasMinimum where Self: ValidationRule {
    func validateMinimum() throws {
        guard value.count >= field.minMax.min else {
            throw ValidationError
                .tooShort(
                    fieldName: field.title,
                    minimum: field.minMax.min
                )
        }
    }
}

public extension HasMaximum where Self: ValidationRule {
    func validateMaximum() throws {
        guard value.count <= field.minMax.max else {
            throw ValidationError.tooLong(
                fieldName: field.title,
                maximum: field.minMax.max
            )
        }
    }
}

public extension IsMandatory where Self: ValidationRule {
    func validateIsEmpty() throws {
        guard value.isEmpty == false else {
            throw ValidationError.empty(
                fieldName: field.title
            )
        }
    }
}

public typealias PasswordStrengthCheck = ((String) throws -> Void)

public protocol PasswordStrengthValidator: AnyObject {
    var checks: [PasswordStrengthCheck] { get }

    func validateStrength() throws
}

public extension PasswordStrengthValidator where Self: ValidationRule {
    func validateStrength() throws {
        try checks.forEach { try $0(self.value) }
    }
}

public enum ValidationError {
    // MARK: - Authentication Validations

    case tooShort(fieldName: String, minimum: Int)
    case tooLong(fieldName: String, maximum: Int)

    case tooShortWithoutMinimum(fieldName: String)
    case tooLongWithoutMaximum(fieldName: String)
    case empty(fieldName: String)
    case invalid(fieldName: String)

    case containOnly(FieldRequirement, String)
    case mustContain(FieldRequirement, String)
    case cantContain(FieldRequirement, String)

    case emailInvalid

    case passwordWeak(reason: PasswordWeaknessReason)
    case passwordMismatch

    // MARK: - Add Post Form Validations

    case videoLongerThanMaxDuration
    case noPrivacyModifierSelected
}

public enum PasswordWeaknessReason {
    case noNumbers

    var errorDescription: String {
        switch self {
        case .noNumbers:
            return L10n.authErrorMessagePasswordAtLeastOneNumber
        }
    }
}

public enum FieldRequirement: String {
    case letters
    case numbers
    case symbols
    case whiteSpaces = "white spaces"
}

extension ARamy.ValidationError: Error, LocalizedError {
    public var errorDescription: String? {
      switch self {
      case let .empty(fieldName):
        return L10n.authErrorMessageMandatory(fieldName)
      case .emailInvalid:
          return L10n.pleaseEnterCorrectEmailAddress
      case .passwordMismatch:
          return L10n.passwordMismatch
      case let .passwordWeak(reason):
          return reason.errorDescription
      case .videoLongerThanMaxDuration:
          return L10n
              .addPostValidationErrorVideoLongerThanMaxDuration(
                  ARConfigurations.Video.maxDurationInSeconds
              )
      case .noPrivacyModifierSelected:
          return L10n.addPostPrivacyValidationErrorNoModifierSelected
      case let .tooShort(fieldName, minimum):
          return L10n.validationErrorFieldTooShort(fieldName, minimum)
      case let .tooLong(fieldName, maximum):
          return L10n.validationErrorFieldTooShort(fieldName, maximum)
      case let .containOnly(requirement, fieldName):
          return L10n.validationErrorFieldCanContainOnly(fieldName, requirement.rawValue)
      case let .cantContain(requirement, fieldName):
          return L10n.validationErrorFieldCantContain(fieldName, requirement.rawValue)
      case let .mustContain(requirement, fieldName):
          return L10n.validationErrorFieldMustContain(fieldName, requirement.rawValue)
      case let .tooShortWithoutMinimum(fieldName):
          return L10n.validationErrorTooShortUnknownMinimum(fieldName)
      case let .tooLongWithoutMaximum(fieldName):
          return L10n.validationErrorTooLongUnknownMaximum(fieldName)
      case let .invalid(fieldName):
          return L10n.validationErrorTooInvalidField(fieldName)
      }
  }
}
