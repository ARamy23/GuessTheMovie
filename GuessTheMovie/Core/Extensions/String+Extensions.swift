//
//  String+Extensions.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/2/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

public extension String {
  static let empty = ""
  
  func toURL() -> URL? {
    URL(string: self)
  }
  
  var asError: Error {
    return NSError(domain: self, code: -1, userInfo: [NSLocalizedDescriptionKey: self])
  }
  
  /// The method loops over the currently supported formats and picks the suitable one
  /// Then returns a String with the format that the UI requires
  /// - Parameter requiredFormat: the format that the caller needs
  /// - Returns: Localized Formatted Date String
  func formattedDate(to requiredFormat: DateFormat) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.calendar = Calendar(identifier: .gregorian)
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    let suitableFormat = DateFormat
      .allCases
      .first { (possibleFormat: DateFormat) -> Bool in
      dateFormatter.dateFormat = possibleFormat.rawValue
      return dateFormatter.date(from: self) != nil
      }?.rawValue ?? .empty
    
    dateFormatter.dateFormat = suitableFormat
    guard let date = dateFormatter.date(from: self) else { return self }
    dateFormatter.calendar = .current
    dateFormatter.locale = .current
    dateFormatter.timeZone = .current
    dateFormatter.dateFormat = requiredFormat.rawValue
    return dateFormatter.string(from: date)
  }
  
  /// The method loops over the currently supported formats and picks the suitable one
  /// Then returns a String with the format that the UI requires
  /// - Parameter requiredFormat: the format that the caller needs
  /// - Returns: Localized Formatted Date
  func formattedDate(to requiredFormat: DateFormat) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.calendar = Calendar(identifier: .gregorian)
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    let suitableFormat = DateFormat
      .allCases
      .first { (possibleFormat: DateFormat) -> Bool in
      dateFormatter.dateFormat = possibleFormat.rawValue
      return dateFormatter.date(from: self) != nil
      }?.rawValue ?? .empty
    
    dateFormatter.dateFormat = suitableFormat
    return dateFormatter.date(from: self) ?? Date()
  }
  
  func matches(_ regex: String) -> Bool {
      return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
  }
}

public extension Optional where Wrapped == String {
  var emptyIfNil: String {
    return self ?? .empty
  }
  var dotIfNil: String {
    return self ?? "."
  }
}

public extension Optional where Wrapped == NSAttributedString {
  
  var emptyIfNil: NSAttributedString {
    return self ?? NSAttributedString(string: .empty)
  }
}

public extension String {
  
  var trimCardNumber: String {
    return self.replacingOccurrences(of: "*", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
  }

  func replacingOccurrences(with this: [String]) -> String {
    var value = self
    this.forEach { value = value.replacingOccurrences(of: $0, with: "") }
    return value
  }

  var trimPhoneNumber: String {
    return
      self.replacingOccurrences(of: "(", with: "")
      .replacingOccurrences(of: ")", with: "")
      .replacingOccurrences(of: "-", with: "")
        .replacingOccurrences(of: " ", with: "")
      .trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  /// The average reading time is 250 word per minute, which makes 4.167 words per second
  /// so for every 4 word, a second is counted, giving user an extra space of reading to make
  /// dynamic toasts plus a minimum of 1 second in case text is too short
  func calculateSuitableReadingTimeInSeconds() -> Double {
      max(1, Double(components(separatedBy: " ").count) / 4.167)
  }
}
