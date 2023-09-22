// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localization {
  internal enum Configuration {
    /// Localizable.strings
    ///   FlipClock
    /// 
    ///   Created by Pedro Ésli Vieira do Nascimento on 15/08/23.
    internal static let title = Localization.tr("Localizable", "Configuration.Title", fallback: "Configuration")
    internal enum Button {
      internal enum DefaultSettings {
        /// Default settings
        internal static let text = Localization.tr("Localizable", "Configuration.Button.DefaultSettings.Text", fallback: "Default settings")
      }
      internal enum Reset {
        /// Reset
        internal static let text = Localization.tr("Localizable", "Configuration.Button.Reset.Text", fallback: "Reset")
      }
      internal enum Review {
        /// Review FlipNeo Clock
        internal static let text = Localization.tr("Localizable", "Configuration.Button.Review.Text", fallback: "Review FlipNeo Clock")
      }
    }
    internal enum ColorInfoSelector {
      internal enum DialTextColor {
        /// Dial text color
        internal static let title = Localization.tr("Localizable", "Configuration.ColorInfoSelector.DialTextColor.Title", fallback: "Dial text color")
      }
      internal enum TintColor {
        /// Tint color
        internal static let title = Localization.tr("Localizable", "Configuration.ColorInfoSelector.TintColor.Title", fallback: "Tint color")
      }
    }
    internal enum ConfirmationDialog {
      /// Are you sure you want to reset to the default settings?
      internal static let text = Localization.tr("Localizable", "Configuration.ConfirmationDialog.Text", fallback: "Are you sure you want to reset to the default settings?")
    }
    internal enum Picker {
      internal enum HourFormat {
        /// Hour format
        internal static let title = Localization.tr("Localizable", "Configuration.Picker.HourFormat.Title", fallback: "Hour format")
      }
      internal enum Military {
        /// 24 hours
        internal static let text = Localization.tr("Localizable", "Configuration.Picker.Military.Text", fallback: "24 hours")
      }
      internal enum System {
        /// System
        internal static let text = Localization.tr("Localizable", "Configuration.Picker.System.Text", fallback: "System")
      }
      internal enum TwoPeriods {
        /// 12 hours
        internal static let text = Localization.tr("Localizable", "Configuration.Picker.TwoPeriods.Text", fallback: "12 hours")
      }
    }
    internal enum Section {
      internal enum App {
        /// App
        internal static let title = Localization.tr("Localizable", "Configuration.Section.App.Title", fallback: "App")
      }
      internal enum General {
        /// General
        internal static let title = Localization.tr("Localizable", "Configuration.Section.General.Title", fallback: "General")
      }
      internal enum Support {
        /// Support
        internal static let title = Localization.tr("Localizable", "Configuration.Section.Support.Title", fallback: "Support")
      }
      internal enum TimeDisplay {
        /// Time display
        internal static let title = Localization.tr("Localizable", "Configuration.Section.TimeDisplay.Title", fallback: "Time display")
      }
    }
    internal enum Text {
      /// Made with ❤️☕️ by Pedro Ésli
      internal static let madeBy = Localization.tr("Localizable", "Configuration.Text.MadeBy", fallback: "Made with ❤️☕️ by Pedro Ésli")
      /// Reset to default settings
      internal static let reset = Localization.tr("Localizable", "Configuration.Text.Reset", fallback: "Reset to default settings")
    }
    internal enum Toggle {
      internal enum DisplaySeconds {
        /// Display seconds
        internal static let title = Localization.tr("Localizable", "Configuration.Toggle.DisplaySeconds.Title", fallback: "Display seconds")
      }
    }
  }
  internal enum Notification {
    /// The time has finished
    internal static let subtitle = Localization.tr("Localizable", "Notification.Subtitle", fallback: "The time has finished")
    /// Timer
    internal static let title = Localization.tr("Localizable", "Notification.Title", fallback: "Timer")
  }
  internal enum StopWatch {
    /// Reset
    internal static let reset = Localization.tr("Localizable", "StopWatch.Reset", fallback: "Reset")
    /// Resume
    internal static let resume = Localization.tr("Localizable", "StopWatch.Resume", fallback: "Resume")
    /// Start
    internal static let start = Localization.tr("Localizable", "StopWatch.Start", fallback: "Start")
    /// Stop
    internal static let stop = Localization.tr("Localizable", "StopWatch.Stop", fallback: "Stop")
  }
  internal enum TimePicker {
    /// hour
    internal static let hour = Localization.tr("Localizable", "TimePicker.Hour", fallback: "hour")
    /// min
    internal static let minute = Localization.tr("Localizable", "TimePicker.Minute", fallback: "min")
    /// s
    internal static let second = Localization.tr("Localizable", "TimePicker.Second", fallback: "s")
  }
  internal enum Timer {
    /// Cancel
    internal static let cancel = Localization.tr("Localizable", "Timer.Cancel", fallback: "Cancel")
    /// Pause
    internal static let pause = Localization.tr("Localizable", "Timer.Pause", fallback: "Pause")
    /// Resume
    internal static let resume = Localization.tr("Localizable", "Timer.Resume", fallback: "Resume")
    /// Start
    internal static let start = Localization.tr("Localizable", "Timer.Start", fallback: "Start")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localization {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
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
// swiftlint:enable all
