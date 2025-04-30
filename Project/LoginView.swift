import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        ZStack {
            BackgroundView()

            VStack {
                Spacer()
                LoginFormView(email: $email, password: $password)
                Spacer()
            }
        }
    }
}

struct LoginFormView: View {
    @Binding var email: String
    @Binding var password: String
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.fill")
                .font(.system(size: 50))
                .foregroundColor(.blue)

            Text("Logowanie")
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

            Button(action: {
                // Tu mogłaby być walidacja
                isLoggedIn = true
            }) {
                Text("Zaloguj")
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
