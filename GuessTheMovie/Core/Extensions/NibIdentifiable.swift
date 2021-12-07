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
//  NibIdentifiable.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 24/03/2021.
//

import UIKit

public protocol NibIdentifiable {
  static var nibIdentifier: String { get }
}

public extension NibIdentifiable {
  static var nib: UINib {
    return UINib(nibName: nibIdentifier, bundle: nil)
  }
}

extension UIView: NibIdentifiable {
  public static var nibIdentifier: String {
    return String(describing: self)
  }
}

extension UIViewController: NibIdentifiable {
  public static var nibIdentifier: String {
    return String(describing: self)
  }
}

public extension NibIdentifiable where Self: UIViewController {
  static func instantiateFromNib() -> Self {
    return Self(nibName: nibIdentifier, bundle: Bundle(for: self))
  }
}

public extension NibIdentifiable where Self: UIView {
  static func instantiateFromNib() -> Self {
    guard let view = UINib(nibName: nibIdentifier, bundle: Bundle(for: self))
      .instantiate(withOwner: nil, options: nil).first as? Self else {
      fatalError("Couldn't find nib file for \(String(describing: Self.self))")
    }
    return view
  }
}

public extension UITableView {
  func registerCell<T: UITableViewCell>(type: T.Type) {
    register(type.nib, forCellReuseIdentifier: String(describing: T.self))
  }

  func registerHeaderFooterView<T: UITableViewHeaderFooterView>(type: T.Type) {
    register(type.nib, forHeaderFooterViewReuseIdentifier: String(describing: T.self))
  }

  func dequeueReusableCell<T: UITableViewCell>(type: T.Type) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
      fatalError("Couldn't find nib file for \(String(describing: T.self))")
    }
    return cell
  }

  func dequeueReusableCell<T: UITableViewCell>(type: T.Type, forIndexPath indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                         for: indexPath) as? T else {
      fatalError("Couldn't find nib file for \(String(describing: T.self))")
    }
    return cell
  }

  func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(type: T.Type) -> T {
    guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T
    else {
      fatalError("Couldn't find nib file for \(String(describing: T.self))")
    }
    return headerFooterView
  }
}

public extension UICollectionView {
  func registerCell<T: UICollectionViewCell>(type: T.Type) {
    register(type.nib, forCellWithReuseIdentifier: String(describing: T.self))
  }

  func dequeueReusableCell<T: UICollectionViewCell>(type: T.Type, forIndexPath indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self),
                                         for: indexPath) as? T else {
      fatalError("Couldn't find nib file for \(String(describing: T.self))")
    }
    return cell
  }
}

