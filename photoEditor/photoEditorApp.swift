import SwiftUI

@main
struct PhotoEditorApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            AuthView(viewModel: authViewModel)
        }
    }
}
