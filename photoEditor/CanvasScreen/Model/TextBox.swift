import SwiftUI

struct TextBox: Identifiable {
    var id: UUID = UUID()
    var text: String = ""
    var isBold: Bool = false
    var offset: CGSize = .zero
    var lastOffset: CGSize = .zero
    var textColor: Color = .white
    var isAdded: Bool = false
}
