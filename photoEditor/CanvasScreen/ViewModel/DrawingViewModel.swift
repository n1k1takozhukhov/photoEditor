import SwiftUI
import PencilKit
import CoreImage
import CoreImage.CIFilterBuiltins

class DrawingViewModel: ObservableObject {
    
    @Published var canvas = PKCanvasView()
    @Published var toolPicker = PKToolPicker()
    @Published var imageData: Data = Data(count: 0)
    @Published var textBoxes: [TextBox] = []
    @Published var rect: CGRect = .zero
    @Published var messageSaveImage: String = ""
    @Published var currentIndex: Int = 0
    @Published var isShowImagePicker = false
    @Published var isShowSuccessSaveAlert = false
    @Published var isShowExitProfileAlert = false
    @Published var isShowingAlert = false
    @Published var isAddNewBox = false
    
    
    ///func is called but the user exit tne editor and wants to return to the default state
    func cancelImegeEditor() {
        imageData = Data(count: 0) // this effect cant be delete current image
        canvas = PKCanvasView() // reboot current hols state
        textBoxes.removeAll() // delete add textBox. and delete all added users textbox
    }
    
    /// this mettor is called but user want callback all editor
    func cancelTextView() {
        toolPicker.setVisible(true, forFirstResponder: canvas) //set toolPicker to visibility canvas to the firts Responder
        canvas.becomeFirstResponder()
        
        // this animation set isAddNewBox to false
        withAnimation {
            isAddNewBox = false
        }
        
        if !textBoxes[currentIndex].isAdded {
            textBoxes.removeLast()
        }
    }
    
    
    
    ///this metod used for safe current hols state and textBox to iamge and safe this image to Photo in iPhone app.
    func saveImage() {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        //start image context with correct frame and settings
        canvas.drawHierarchy(
            in: CGRect(
                origin: .zero,
                size: rect.size
            ), afterScreenUpdates: true
        )
        
        //create sui view, vill witgh all textBox
        let swiftUIView = ZStack {
            ForEach(textBoxes) { [self] box in
                Text(
                    textBoxes[
                        currentIndex
                    ].id ==  box.id && isAddNewBox ? "" : box.text)
                .font(.system(size: 30))
                .fontWeight(box.isBold ? .bold : .none)
                .foregroundStyle(box.textColor)
                .offset(box.offset)
            }
        }
        
        // create viewcontrollr for visibitily other sui view
        let controller = UIHostingController(rootView: swiftUIView).view!
        controller.frame = rect
        
        // set backgroundColor for controller and holst with transparency
        controller.backgroundColor = .clear
        canvas.backgroundColor = .clear
        
        //view eerarhi contrleer in the image context
        controller.drawHierarchy(
            in: CGRect(
                origin: .zero,
                size: rect.size
            ), afterScreenUpdates: true
        )
        
        // Получаем сгенерированное изображение из контекста изображения.
        let generatedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        //complete image context
        UIGraphicsEndImageContext()
        
        //if we success generage image, save to photo in iPhone
        if let image = generatedImage?.pngData() {
            UIImageWriteToSavedPhotosAlbum(
                UIImage(data: image)!,
                nil,
                nil,
                nil
            )
        }
        
        self.messageSaveImage = "imageSavedSuccessfully".localized
        self.isShowSuccessSaveAlert.toggle()
        self.isShowingAlert.toggle()
    }
}
