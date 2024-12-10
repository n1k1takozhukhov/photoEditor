import SwiftUI

struct AuthView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Welcome to Photo Editor")
                    .titleTextStyle()
                
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle()
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .onChange(of: viewModel.email) { _ in
                        viewModel.errorMessage = nil
                    }
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle()
                    .onChange(of: viewModel.password) { _ in
                        viewModel.errorMessage = nil
                    }
                
                // Сообщение об ошибке
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Button(action: {
                    viewModel.login()
                }) {
                    Text("Login")
                }
                .buttonStyle()
                .disabled(!viewModel.isValid || viewModel.isLoading)
                
                Button(action: {
                    viewModel.resetPassword()
                }) {
                    Text("Forgot Password?")
                        .foregroundColor(.blue)
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                }
                
                NavigationLink(
                    destination: photoEditor(),
                    isActive: $viewModel.isAuthenticated
                ) {
                    EmptyView()
                }
            }
            .padding()
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(viewModel: AuthViewModel())
    }
}
