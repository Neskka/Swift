import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        ZStack {
            BackgroundView()

            VStack {
                Spacer()
                RegisterFormView(email: $email, password: $password, confirmPassword: $confirmPassword)
                Spacer()
            }
        }
    }
}

struct RegisterFormView: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var confirmPassword: String

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.badge.plus.fill")
                .font(.system(size: 50))
                .foregroundColor(.blue)

            Text("Rejestracja")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)

            TextField("Adres e-mail", text: $email)
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .keyboardType(.emailAddress)

            SecureField("Hasło", text: $password)
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)

            SecureField("Potwierdź hasło", text: $confirmPassword)
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)

            Button(action: {
                // Możesz dodać walidację
            }) {
                Text("Zarejestruj")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.bottom, 10)
        }
        .frame(maxWidth: 300)
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.9)))
        .padding()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
