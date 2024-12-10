import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var isAuthenticated: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    var isValid: Bool {
        return email.isValidEmail() && password.count >= 6
    }
    
    func login() {
        guard isValid else {
            errorMessage = "Please enter a valid email and password with at least 6 characters."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        // Имитация успешного входа
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
            self.isAuthenticated = true
            print("Logged in successfully with email: \(self.email)")
        }
    }
    
    func resetPassword() {
        print("Password reset for email: \(email)")
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
