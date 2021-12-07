// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal enum Backgrounds {
    internal static let background = ImageAsset(name: "background")
  }
  internal enum Colors {
    internal enum Danger {
      internal static let dangerBackground = ColorAsset(name: "Danger.background")
      internal static let dangerDark = ColorAsset(name: "Danger.dark")
      internal static let dangerDarkMode = ColorAsset(name: "Danger.darkMode")
      internal static let dangerDefault = ColorAsset(name: "Danger.default")
      internal static let dangerLight = ColorAsset(name: "Danger.light")
    }
    internal enum Info {
      internal static let infoBackground = ColorAsset(name: "Info.background")
      internal static let infoDark = ColorAsset(name: "Info.dark")
      internal static let infoDarkMode = ColorAsset(name: "Info.darkMode")
      internal static let infoDefault = ColorAsset(name: "Info.default")
      internal static let infoLight = ColorAsset(name: "Info.light")
    }
    internal enum Monochromatic {
      internal static let monochromaticAsh = ColorAsset(name: "Monochromatic.ash")
      internal static let monochromaticBackground = ColorAsset(name: "Monochromatic.background")
      internal static let monochromaticBody = ColorAsset(name: "Monochromatic.body")
      internal static let monochromaticInput = ColorAsset(name: "Monochromatic.input")
      internal static let monochromaticLabel = ColorAsset(name: "Monochromatic.label")
      internal static let monochromaticLine = ColorAsset(name: "Monochromatic.line")
      internal static let monochromaticOffblack = ColorAsset(name: "Monochromatic.offblack")
      internal static let monochromaticOffwhite = ColorAsset(name: "Monochromatic.offwhite")
      internal static let monochromaticPlaceholder = ColorAsset(name: "Monochromatic.placeholder")
    }
    internal enum Primary {
      internal static let primaryBackground = ColorAsset(name: "Primary.background")
      internal static let primaryDark = ColorAsset(name: "Primary.dark")
      internal static let primaryDarkMode = ColorAsset(name: "Primary.darkMode")
      internal static let primaryDefault = ColorAsset(name: "Primary.default")
      internal static let primaryLight = ColorAsset(name: "Primary.light")
    }
    internal enum Secondary {
      internal static let secondaryBackground = ColorAsset(name: "Secondary.background")
      internal static let secondaryDark = ColorAsset(name: "Secondary.dark")
      internal static let secondaryDarkMode = ColorAsset(name: "Secondary.darkMode")
      internal static let secondaryDefault = ColorAsset(name: "Secondary.default")
      internal static let secondaryLight = ColorAsset(name: "Secondary.light")
    }
    internal enum Success {
      internal static let successBackground = ColorAsset(name: "Success.background")
      internal static let successDark = ColorAsset(name: "Success.dark")
      internal static let successDarkMode = ColorAsset(name: "Success.darkMode")
      internal static let successDefault = ColorAsset(name: "Success.default")
      internal static let successLight = ColorAsset(name: "Success.light")
    }
    internal enum Transparency {
      internal static let transparencyDarkFull = ColorAsset(name: "Transparency.dark.full")
      internal static let transparencyLightFull = ColorAsset(name: "Transparency.light.full")
    }
    internal enum Warning {
      internal static let warningBackground = ColorAsset(name: "Warning.background")
      internal static let warningDark = ColorAsset(name: "Warning.dark")
      internal static let warningDarkMode = ColorAsset(name: "Warning.darkMode")
      internal static let warningDefault = ColorAsset(name: "Warning.default")
      internal static let warningLight = ColorAsset(name: "Warning.light")
    }
  }
  internal enum Icons {
    internal static let close = ImageAsset(name: "Close")
    internal static let filledStar = ImageAsset(name: "Filled Star")
    internal static let star = ImageAsset(name: "Star")
  }
  internal enum Illustrations {
    internal static let logo = ImageAsset(name: "Logo")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
