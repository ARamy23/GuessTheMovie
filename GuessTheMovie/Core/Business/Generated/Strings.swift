// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Write a caption...
  internal static let addPostCaptionPlaceholder = L10n.tr("Localizables", "add_post_caption_placeholder")
  /// Post
  internal static let addPostFormNavigationBarPostButton = L10n.tr("Localizables", "add_post_form_navigation_bar_post_button")
  /// Add Post
  internal static let addPostNavigationTitle = L10n.tr("Localizables", "add_post_navigation_title")
  /// Photo Library Permission is missing, to be able to add a post, you need to allow it from the iOS's Settings App
  internal static let addPostNoPhotoPermissionGivenErrorMessage = L10n.tr("Localizables", "add_post_no_photo_permission_given_error_message")
  /// Edit Privacy
  internal static let addPostPrivacyEditPrivacyTitle = L10n.tr("Localizables", "add_post_privacy_edit_privacy_title")
  /// Friends
  internal static let addPostPrivacyFriendsTitle = L10n.tr("Localizables", "add_post_privacy_friends_title")
  /// Public
  internal static let addPostPrivacyPublicTitle = L10n.tr("Localizables", "add_post_privacy_public_title")
  /// Looks like you haven't selected a privacy modifier
  internal static let addPostPrivacyValidationErrorNoModifierSelected = L10n.tr("Localizables", "add_post_privacy_validation_error_no_modifier_selected")
  /// Post Submitted Successfully!
  internal static let addPostSuccessMessagePostSubmitted = L10n.tr("Localizables", "add_post_success_message_post_submitted")
  /// Video can't be longer than %@ seconds
  internal static func addPostValidationErrorVideoLongerThanMaxDuration(_ p1: Any) -> String {
    return L10n.tr("Localizables", "add_post_validation_error_video_longer_than_max_duration", String(describing: p1))
  }
  /// At least 2 chars
  internal static let atLeast2Chars = L10n.tr("Localizables", "At least 2 chars")
  /// At least 3 chars
  internal static let atLeast3Chars = L10n.tr("Localizables", "At least 3 chars")
  /// Email and/or password doesn't match
  internal static let authErrorMessageEmailAndPasswordDoesntMatch = L10n.tr("Localizables", "auth_error_message_email_and_password_doesnt_match")
  /// Sorry, link has expired.
  internal static let authErrorMessageInvalidToken = L10n.tr("Localizables", "auth_error_message_invalid_token")
  /// %@ is required.
  internal static func authErrorMessageMandatory(_ p1: Any) -> String {
    return L10n.tr("Localizables", "auth_error_message_mandatory", String(describing: p1))
  }
  /// A password must contain at least 1 number
  internal static let authErrorMessagePasswordAtLeastOneNumber = L10n.tr("Localizables", "auth_error_message_password_at_least_one_number")
  /// You're already verified.
  internal static let authErrorMessageYouAreAlreadyVerified = L10n.tr("Localizables", "auth_error_message_you_are_already_verified")
  /// Add New Post
  internal static let burgerMenuTitleAddNewPost = L10n.tr("Localizables", "burger_menu_title_add_new_post")
  /// Bag
  internal static let burgerMenuTitleBag = L10n.tr("Localizables", "burger_menu_title_bag")
  /// Calendar
  internal static let burgerMenuTitleCalendar = L10n.tr("Localizables", "burger_menu_title_calendar")
  /// Developer Mode
  internal static let burgerMenuTitleDeveloperMode = L10n.tr("Localizables", "burger_menu_title_developer_mode")
  /// Look Tracker
  internal static let burgerMenuTitleLookTracker = L10n.tr("Localizables", "burger_menu_title_look_tracker")
  /// My QR Code
  internal static let burgerMenuTitleMyQrCode = L10n.tr("Localizables", "burger_menu_title_my_qr_code")
  /// Notifications
  internal static let burgerMenuTitleNotifications = L10n.tr("Localizables", "burger_menu_title_notifications")
  /// Parties
  internal static let burgerMenuTitleParties = L10n.tr("Localizables", "burger_menu_title_parties")
  /// Scan QR
  internal static let burgerMenuTitleScanQr = L10n.tr("Localizables", "burger_menu_title_scan_qr")
  /// Send Gift
  internal static let burgerMenuTitleSendGift = L10n.tr("Localizables", "burger_menu_title_send_gift")
  /// Shop Together
  internal static let burgerMenuTitleShopTogether = L10n.tr("Localizables", "burger_menu_title_shop_together")
  /// Wardrobe
  internal static let burgerMenuTitleWardrobe = L10n.tr("Localizables", "burger_menu_title_wardrobe")
  /// Category Calories: %@
  internal static func categoryCalories(_ p1: Any) -> String {
    return L10n.tr("Localizables", "category_calories", String(describing: p1))
  }
  /// Category Description: %@
  internal static func categoryDescription(_ p1: Any) -> String {
    return L10n.tr("Localizables", "category_description", String(describing: p1))
  }
  /// Category Name: %@
  internal static func categoryName(_ p1: Any) -> String {
    return L10n.tr("Localizables", "category_name", String(describing: p1))
  }
  /// We’ve sent a link  to your Email so you can reset your password
  internal static let checkEmailForgetPasswordSubtitle = L10n.tr("Localizables", "check_email_forget_password_subtitle")
  /// A new Email was sent to your inbox.
  internal static let checkEmailSuccessMessage = L10n.tr("Localizables", "check_email_success_message")
  /// We’ve sent a link  to your Email so you can verify your newly made GuessTheMovie ✨ account.
  internal static let checkEmailVerifyEmailSubtitle = L10n.tr("Localizables", "check_email_verify_email_subtitle")
  /// Clear Cache
  internal static let clearCache = L10n.tr("Localizables", "clear cache")
  /// Continue
  internal static let `continue` = L10n.tr("Localizables", "continue")
  /// Continue as guest
  internal static let continueAsGuest = L10n.tr("Localizables", "Continue as guest")
  /// There is an account already using this email
  internal static let emailAlreadyExists = L10n.tr("Localizables", "email already exists")
  /// It appears that you've registered with this email using a password not using your social account, please write this email and password in the fields above
  internal static let emailAlreadyExistsWhileUsingSocial = L10n.tr("Localizables", "email already exists while using social")
  /// You need to verify your account, please check your inbox
  internal static let emailNeedVerification = L10n.tr("Localizables", "email need verification")
  /// Given email is not valid, can you please double check it?
  internal static let emailNotValid = L10n.tr("Localizables", "email_not_valid")
  /// The %@ can't be empty.
  internal static func fieldCantBeEmpty(_ p1: Any) -> String {
    return L10n.tr("Localizables", "field_cant_be_empty", String(describing: p1))
  }
  /// Art
  internal static let filtersTitleArt = L10n.tr("Localizables", "filters_title_art")
  /// Beauty
  internal static let filtersTitleBeauty = L10n.tr("Localizables", "filters_title_beauty")
  /// Brands
  internal static let filtersTitleBrands = L10n.tr("Localizables", "filters_title_brands")
  /// Exhibition
  internal static let filtersTitleExhibition = L10n.tr("Localizables", "filters_title_exhibition")
  /// Men
  internal static let filtersTitleMen = L10n.tr("Localizables", "filters_title_men")
  /// Women
  internal static let filtersTitleWomen = L10n.tr("Localizables", "filters_title_women")
  /// Oops... Something went wrong!
  internal static let genericError = L10n.tr("Localizables", "generic_error")
  /// Hi there!
  internal static let hiThere = L10n.tr("Localizables", "hi_there")
  /// Home
  internal static let home = L10n.tr("Localizables", "Home")
  /// Tagged People: %@
  internal static func homeCaptionTaggedPeople(_ p1: Any) -> String {
    return L10n.tr("Localizables", "home_caption_tagged_people", String(describing: p1))
  }
  /// Buy
  internal static let homeSocialBuyButtonSubtitle = L10n.tr("Localizables", "home_social_buy_button_subtitle")
  /// Letters & numbers only
  internal static let lettersNumbersOnly = L10n.tr("Localizables", "Letters & numbers only")
  /// Letters only
  internal static let lettersOnly = L10n.tr("Localizables", "Letters only")
  /// Logout
  internal static let logout = L10n.tr("Localizables", "logout")
  /// Me
  internal static let me = L10n.tr("Localizables", "Me")
  /// Messages
  internal static let messages = L10n.tr("Localizables", "Messages")
  /// My Name Ahmed Ramy! and am glad that you made it!
  internal static let myName = L10n.tr("Localizables", "my_name")
  /// Names can't contain emojis.
  internal static let namesCantContainEmojis = L10n.tr("Localizables", "names_cant_contain_emojis")
  /// Names can't contain numbers.
  internal static let namesCantContainNumbers = L10n.tr("Localizables", "names_cant_contain_numbers")
  /// Names can't contain special characters.
  internal static let namesCantContainSpecialCharacters = L10n.tr("Localizables", "names_cant_contain_special_characters")
  /// No internet connection
  internal static let noInternetConnection = L10n.tr("Localizables", "No internet connection")
  /// Username can’t have symbols
  internal static let noSymbolsInUsername = L10n.tr("Localizables", "no symbols in username")
  /// Password mismatch
  internal static let passwordMismatch = L10n.tr("Localizables", "Password mismatch")
  /// ••••••••••••••••••••••••••
  internal static let passwordHintLocked = L10n.tr("Localizables", "password_hint_locked")
  /// Your Super Secret Password.
  internal static let passwordHintUnlocked = L10n.tr("Localizables", "password_hint_unlocked")
  /// Password is too short.
  internal static let passwordTooShort = L10n.tr("Localizables", "password_too_short")
  /// There is an account already using this phone number
  internal static let phoneAlreadyExists = L10n.tr("Localizables", "phone already exists")
  /// Please enter at least 5 characters and at least 1 number
  internal static let pleaseEnterAtLeast5CharactersAndAtLeast1Number = L10n.tr("Localizables", "Please enter at least 5 characters and at least 1 number")
  /// Please enter correct email address
  internal static let pleaseEnterCorrectEmailAddress = L10n.tr("Localizables", "Please enter correct email address")
  /// Built with DX and Speed in mind!
  internal static let purpose = L10n.tr("Localizables", "purpose")
  /// You're now witnessing the power of RamySDK
  internal static let ramySDK = L10n.tr("Localizables", "ramy_s_d_k")
  /// Your Account was registered successfully, now you can login.
  internal static let registerSuccessMessage = L10n.tr("Localizables", "register_success_message")
  /// Search
  internal static let search = L10n.tr("Localizables", "Search")
  /// Some Thing Went Wrong
  internal static let someThingWentWrong = L10n.tr("Localizables", "Some Thing Went Wrong")
  /// Trends
  internal static let trends = L10n.tr("Localizables", "Trends")
  /// There is an account already using this username, please use a different Username.
  internal static let usernameAlreadyExists = L10n.tr("Localizables", "username_already_exists")
  /// Username doesn't exist.
  internal static let userNameDoesntExists = L10n.tr("Localizables", "userName_doesnt_exists")
  /// +0123456789
  internal static let validationAllowedPhoneNumberCharacters = L10n.tr("Localizables", "validation_allowed_phone_number_characters")
  /// %@ can only contain %@.
  internal static func validationErrorFieldCanContainOnly(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("Localizables", "validation_error_field_can_contain_only", String(describing: p1), String(describing: p2))
  }
  /// %@ can't contain %@.
  internal static func validationErrorFieldCantContain(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("Localizables", "validation_error_field_cant_contain", String(describing: p1), String(describing: p2))
  }
  /// %@ must contain %@.
  internal static func validationErrorFieldMustContain(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("Localizables", "validation_error_field_must_contain", String(describing: p1), String(describing: p2))
  }
  /// %@ is too long. (long: %@)
  internal static func validationErrorFieldTooLong(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("Localizables", "validation_error_field_too_long", String(describing: p1), String(describing: p2))
  }
  /// %@ is too short. (min: %@)
  internal static func validationErrorFieldTooShort(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("Localizables", "validation_error_field_too_short", String(describing: p1), String(describing: p2))
  }
  /// %@ is invalid.
  internal static func validationErrorTooInvalidField(_ p1: Any) -> String {
    return L10n.tr("Localizables", "validation_error_too_invalid_field", String(describing: p1))
  }
  /// %@ is too long.
  internal static func validationErrorTooLongUnknownMaximum(_ p1: Any) -> String {
    return L10n.tr("Localizables", "validation_error_too_long_unknown_maximum", String(describing: p1))
  }
  /// %@ is too short.
  internal static func validationErrorTooShortUnknownMinimum(_ p1: Any) -> String {
    return L10n.tr("Localizables", "validation_error_too_short_unknown_minimum", String(describing: p1))
  }
  /// Confirm Password
  internal static let validationFieldNameConfirmPassword = L10n.tr("Localizables", "validation_field_name_confirm_password")
  /// Country Code
  internal static let validationFieldNameCountryCode = L10n.tr("Localizables", "validation_field_name_country_code")
  /// Email
  internal static let validationFieldNameEmail = L10n.tr("Localizables", "validation_field_name_email")
  /// First Name
  internal static let validationFieldNameFirstname = L10n.tr("Localizables", "validation_field_name_firstname")
  /// Last Name
  internal static let validationFieldNameLastname = L10n.tr("Localizables", "validation_field_name_lastname")
  /// Mobile
  internal static let validationFieldNameMobile = L10n.tr("Localizables", "validation_field_name_mobile")
  /// Password
  internal static let validationFieldNamePassword = L10n.tr("Localizables", "validation_field_name_password")
  /// Username
  internal static let validationFieldNameUsername = L10n.tr("Localizables", "validation_field_name_username")
  /// Username can't have white spaces
  internal static let whitespaceInUsername = L10n.tr("Localizables", "whitespace in username")
  /// Your current password
  internal static let yourCurrentPassword = L10n.tr("Localizables", "your_current_password")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
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
