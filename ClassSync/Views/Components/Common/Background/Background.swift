import SwiftUI

struct Background: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color(hex: "#00FF73"), Color(hex: "#8176FE")]),
            startPoint: UnitPoint(x: 0.5, y: 0),     // 上部中央
            endPoint: UnitPoint(x: 1, y: 1)          // 右下
        )
        .ignoresSafeArea()
    }
}

#Preview {
    Background()
}
