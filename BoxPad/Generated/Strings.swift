// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// タイトルが未入力です
  internal static let addEmptyTitle = L10n.tr("Localizable", "add_empty_title")
  /// アイテム追加に失敗しました\nリトライしてください
  internal static let addSendError = L10n.tr("Localizable", "add_send_error")
  /// 閉じる
  internal static let libraryAccsessCloseButton = L10n.tr("Localizable", "library_accsess_closeButton")
  /// 『設定』でフォトライブラリへのアクセスを許可してください
  internal static let libraryAccsessMessage = L10n.tr("Localizable", "library_accsess_message")
  /// 設定へ
  internal static let libraryAccsessSettingButton = L10n.tr("Localizable", "library_accsess_settingButton")
  /// フォトライブラリへのアクセスを求めています
  internal static let libraryAccsessTitle = L10n.tr("Localizable", "library_accsess_title")
  /// アイテム登録
  internal static let titleAddPage = L10n.tr("Localizable", "title_add_page")
  /// HOME
  internal static let titleHomePage = L10n.tr("Localizable", "title_home_page")
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
