import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var isShowPicker: Bool
    @Binding var imageData: Data
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> some PHPickerViewController {
        let picker = PHPickerViewController(configuration: PHPickerConfiguration())
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {    }
    
    class Coordinator : NSObject, PHPickerViewControllerDelegate {
        
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard let firstResult = results.first,
                  firstResult.itemProvider.canLoadObject(ofClass: UIImage.self) else {
                self.parent.isShowPicker.toggle()
                return
            }
            
            firstResult.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                guard let self else { return }
                
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self.parent.imageData = image.pngData()!
                    }
                    self.parent.isShowPicker.toggle()
                }
            }
        }
    }
}
