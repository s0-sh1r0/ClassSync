import SwiftUI

struct ConfilmButton<Destination: View>: View {
    var labelText: String
    var destination: Destination
    var action: () -> Void

    init(labelText: String = "確定", destination: Destination = TopView(), action: @escaping () -> Void = {}) {
        self.labelText = labelText
        self.destination = destination
        self.action = action
    }

    var body: some View {
        NavigationLink(destination: destination) {
            Button(action: {
                action()
            }) {
                Text(labelText)
                    .font(.title3)
                    .foregroundColor(.white)
                    .custom3DBackground(width: 350, height: 50, cornerRadius: 10)
            }
        }
    }
}

#Preview {
    ConfilmButton()
}
