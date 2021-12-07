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
// Promise.swift
// ARamy
//
// Created by Ahmed Ramy on 05/12/2021
// Copyright © 2021 Ahmed Ramy. All rights reserved.
//

import Foundation

public typealias Future<T> = Promise<ARExpected<T>>
public typealias Guarentee<T> = Promise<T>

/// Lightweight Promise Wrapper for better code readability
/// ## Promise
/// ### Normal way of doing things
///```
/// func asyncWork(completion: (String) -> Void) {
///     // ...
///     completion("test")
/// }
///
/// func asyncWorkNext(completion: (String) -> Void) { ... }
///
/// asyncWork { value in
///    print(value)
///    asyncWorkNext { string in
///     asyncWorkNext { string in
///       asyncWorkNext { string in
///         ... (Triangle of Doom issue)
///       }
///     }
///   }
/// }
///```
///
/// ### With Promise
///```
/// let asyncPromise = Promise<String> { resolve in
///    // ...
///    resolve("test")
/// }
///
/// let asyncPromise2 = Promise<String> { resolve in
///    // ...
///    resolve("test")
/// }
///
/// let asyncPromise3 = Promise<String> { resolve in
///    // ...
///    resolve("test")
/// }
///
/// asyncPromise.then(asyncPromise2).then(asyncPromise3)
///
/// // OR
///
/// Promise<String> { resolve in ... }.then(Promise<Int> { ...}).then(Promise<Bool> { ... })
///
/// ```
public class Promise<Value> {
  
  enum State<T> {
    case pending
    case resolved(T)
  }
  
  private var state: State<Value> = .pending
  private var callbacks: [(Value) -> Void] = []
  
  init(executor: (_ resolve: @escaping (Value) -> Void) -> Void) {
    executor(resolve)
  }
  
  // observe
  public func then(_ onResolved: @escaping (Value) -> Void) {
    callbacks.append(onResolved)
    triggerCallbacksIfResolved()
  }
  
  // flatMap
  public func then<NewValue>(_ onResolved: @escaping (Value) -> Promise<NewValue>) -> Promise<NewValue> {
    return Promise<NewValue> { resolve in
      then { value in
        onResolved(value).then(resolve)
      }
    }
  }
  
  // map
  public func then<NewValue>(_ onResolved: @escaping (Value) -> NewValue) -> Promise<NewValue> {
    return then { value in
      return Promise<NewValue> { resolve in
        resolve(onResolved(value))
      }
    }
  }
  
  private func resolve(value: Value) {
    updateState(to: .resolved(value))
  }
  
  private func updateState(to newState: State<Value>) {
    guard case .pending = state else { return }
    state = newState
    triggerCallbacksIfResolved()
  }
  
  private func triggerCallbacksIfResolved() {
    guard case let .resolved(value) = state else { return }
    callbacks.forEach { callback in
      callback(value)
    }
    callbacks.removeAll()
  }
}
