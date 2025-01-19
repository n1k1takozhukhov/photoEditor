import SwiftUI

struct MenuView: View {
    
    @EnvironmentObject var viewModel: DrawingViewModel
    
    var body: some View {
        Button(role: .destructive) {
            viewModel.isShowImagePicker = true
        } label: {
            Text("Обработать фото".localized)
                .bold()
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                )
        }
    }
}
