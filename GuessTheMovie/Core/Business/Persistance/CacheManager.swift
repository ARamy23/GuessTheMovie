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
//  CacheManager.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

public final class CacheManager: CacheProtocol {
    public static let main: CacheManager = .init()
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    private lazy var encryptedStorage = EncryptedStorage()
    private lazy var userDefaultsStorage = UserDefaultsStorage()

    public init(
        decoder: JSONDecoder = .init(),
        encoder: JSONEncoder = .init()
    ) {
        self.decoder = decoder
        self.encoder = encoder
    }

    public func fetch<T: Cachable>(_: T.Type, for key: StorageKey) -> T? {
        getSuitableStorage(from: key.suitableStorage).fetchValue(for: key)
    }

    public func save<T: Cachable>(_ value: T, for key: StorageKey) throws {
        try getSuitableStorage(from: key.suitableStorage).save(value: value, for: key)
    }

    public func remove(for key: StorageKey) {
        getSuitableStorage(from: key.suitableStorage).remove(for: key)
    }
}

private extension CacheManager {
    func getSuitableStorage(from choice: SupportedStorage) -> Storage {
        switch choice {
        case .encrypted:
            return encryptedStorage
        case .userDefaults:
            return userDefaultsStorage
        }
    }
}

public extension CacheManager {
    enum SupportedStorage {
        case userDefaults
        case encrypted
    }
}
