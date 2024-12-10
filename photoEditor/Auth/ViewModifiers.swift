import SwiftUI

struct TextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.2), radius: 5)
    }
}

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
    }
}

struct TitleTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .fontWeight(.bold)
            .padding(.bottom, 20)
    }
}

extension View {
    func textFieldStyle() -> some View {
        self.modifier(TextFieldModifier())
    }

    func buttonStyle() -> some View {
        self.modifier(ButtonModifier())
    }

    func titleTextStyle() -> some View {
        self.modifier(TitleTextModifier())
    }
}


#Preview {
    AuthView(viewModel: AuthViewModel())
}
