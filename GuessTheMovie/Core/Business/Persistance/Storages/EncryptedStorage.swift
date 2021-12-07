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
//  EncryptedStorage.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 24/04/2021.
//

import Foundation
import KeychainSwift

public final class EncryptedStorage {
    private let keychain = KeychainSwift()
}

extension EncryptedStorage: WritableStorage {
    public func remove(for key: StorageKey) {
        keychain.delete(key.key)
    }

    public func save<T: Cachable>(value: T, for key: StorageKey) throws {
        keychain.set(value.encode(), forKey: key.key)
    }
}

extension EncryptedStorage: ReadableStorage {
    public func fetchValue<T: Cachable>(for key: StorageKey) -> T? {
        if let value = keychain.getData(key.key)?.decode(T.self) {
            return value
        } else {
            LoggersManager.error(message: "Couldn't find object related to key: \(key)")
            return nil
        }
    }
}
