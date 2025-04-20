import SwiftUI

struct ConfilmButton: View {
    var body: some View {
        NavigationLink(destination: TopView()) {
            Text("確定")
                .font(.title3)
                .foregroundColor(.white)
                .custom3DBackground(width: 350, height: 50, cornerRadius: 10)
        }
    }
}

#Preview {
    ConfilmButton()
}
