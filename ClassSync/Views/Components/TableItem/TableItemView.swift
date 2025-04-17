import SwiftUI

struct TableItemView: View {
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        ZStack {
            Color(.gray)
            
            VStack {
                Spacer()
                Text("授業名")
                Spacer()
                
                Text("教室名")
                    .background()
                    .padding(.bottom)
            }
        }
        .frame(width: width, height: height)
        .border(Color.white)
        .overlay (
            Rectangle()
                .frame(width: 10)
                .foregroundColor(.black),
            alignment: .leading
        )
    }
}

#Preview {
    TableItemView(width: 70, height: 100)
}
