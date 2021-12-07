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
//  SentryLogger.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 23/10/2021.
//

import Sentry

public enum SentryService {
    static func setup() {
        SentrySDK.start { options in
            options.dsn = Configurations.default.dsn
            options.debug = Configurations.default.debug
            options.environment = Configurations.default.environment
            options.tracesSampleRate = Configurations.default.traceSampleRate
        }
    }
}

private extension SentryService {
    struct Configurations {
        let dsn: String
        let debug: Bool
        let traceSampleRate: NSNumber

        #if DEBUG
            let environment: String = "Development"
        #elseif STAGING
            let environment: String = "Staging"
        #else
            let environment: String = "Production"
        #endif

        static let `default`: Configurations = .init(
            dsn: "https://e2abda70385740b1ae883d666e3ba8e6@o1070827.ingest.sentry.io/6067198",
            debug: false,
            traceSampleRate: 1.0
        )
    }
}

final class SentryLogger: LogEngine {
    public static let main: SentryLogger = .init()

    private func createEvent(level: SentryLevel, message: String) -> Event {
        let event = Event(level: level)
        event.message = SentryMessage(formatted: message)
//        event.user = createUser()
        return event
    }

//    private func createUser() -> Sentry.User? {
//        guard let userInfo = UserService.main.user.value.userInfo else { return nil }
//        let user: Sentry.User = .init()
//        user.userId = "RamySDK's ID: \(userInfo.id)"
//        user.email = "\(userInfo.email ?? "Unknown")"
//        user.username = "\(userInfo.username)"
//        user.data = [
//            "RamySDK's User Info": userInfo.asDictionary(),
//        ]
//
//        return user
//    }

    public func info(message: String) {
        SentrySDK.capture(event: createEvent(level: .info, message: message))
    }

    public func warn(message: String) {
        SentrySDK.capture(event: createEvent(level: .warning, message: message))
    }

    public func error(message: String) {
        SentrySDK.capture(event: createEvent(level: .error, message: message))
    }
}
