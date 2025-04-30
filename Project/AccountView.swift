import SwiftUI

struct AccountView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some View {
        VStack {
            Text("Informacje o koncie użytkownika")
                .font(.title)
                .padding()

            Spacer()

            Button(action: {
                isLoggedIn = false
            }) {
                Text("Wyloguj się")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .foregroundColor(.red)
                    .background(Color.cyan)
            }
        }
    }
}

#Preview {
    AccountView()
}
