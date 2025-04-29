import SwiftUI

struct TableItemView: View {
    let width: CGFloat
    let height: CGFloat
    let color: Color

    var body: some View {
        ZStack {
            Color(color.opacity(0.9))
            
            VStack {
                Spacer()
                Text("授業名")
                Spacer()
                
                Text("教室名")
                    .foregroundColor(.black)
                    .font(.footnote)
                    .padding(.horizontal, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.white)
                    )
                    .padding(.bottom, 4)
            }
        }
        .frame(width: width, height: height)
        .border(Color.white)
        .cornerRadius(8)
    }
}

#Preview {
    TableItemView(width: 70, height: 100, color: .blue)
}
