import SwiftUI

struct DrawingScreen: View {
    
    @EnvironmentObject var viewModel: DrawingViewModel
    
    var body: some View {
        ZStack {
            GeomentyReaderView()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                saveButton
            }
            ToolbarItem(placement: .topBarTrailing) {
                plusButton
            }
            ToolbarItem(placement: .topBarTrailing) {
                cancelButton
            }
        }
    }
    
    private var saveButton: some View {
        Button {
            viewModel.saveImage()
        } label: {
            Text("Save")
        }
    }
    
    private var plusButton: some View {
        Button {
            viewModel.textBoxes.append(TextBox())
            viewModel.currentIndex = viewModel.textBoxes.count - 1
            withAnimation {
                viewModel.isAddNewBox.toggle()
            }
            viewModel.toolPicker.setVisible(
                false,
                forFirstResponder: viewModel.canvas
            )
            viewModel.canvas.resignFirstResponder()
        } label: {
            Image(systemName: "plus")
        }
    }
    
    private var cancelButton: some View {
        Button {
            viewModel.cancelImegeEditor()
        } label: {
            Image(systemName: "xmark")
        }
    }
}

#Preview {
    DrawingScreen()
}
