import SwiftUI

struct StarnView: View {
    
    @StateObject var viewModel = DrawingViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                if UIImage(data: viewModel.imageData) != nil {
                    DrawingScreen()
                } else {
                    MenuView()
                        .padding()
                }
            }
            .navigationTitle("editor".localized)
            
            if viewModel.isAddNewBox {
                AddNewBoxView()
            }
        }
        .environmentObject(viewModel)
        .sheet(isPresented: $viewModel.isShowImagePicker) {
            ImagePicker(
                isShowPicker: $viewModel.isShowImagePicker,
                imageData: $viewModel.imageData
            )
            .ignoresSafeArea()
        }
        .alert(isPresented: $viewModel.isShowingAlert) {
            if viewModel.isShowSuccessSaveAlert {
                return Alert(title: Text(viewModel.messageSaveImage),
                             dismissButton: .default(Text("ok".localized))
                )
            } else {
                return Alert(title: Text("Ошибка..."),
                             dismissButton: .default(Text("ok".localized))
                )
            }
        }
    }
}


#Preview {
    StarnView()
}
