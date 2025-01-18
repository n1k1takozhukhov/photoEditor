import Foundation


extension String {
    var localized: String {
        NSLocalizedString(self, comment: "\(self) count not be found in Localization.strings")
    }
}
