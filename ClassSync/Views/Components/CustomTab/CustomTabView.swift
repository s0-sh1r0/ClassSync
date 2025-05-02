import SwiftUI

struct CustomTabView: View {
    
    @Binding var selection: Int
    
    @State var rotation: CGFloat = 0.0
    
    let tab: [(image: String, title: String)] = [
        ("house", "時間割"),
        ("list.bullet.rectangle.portrait", "課題"),
        ("pencil.and.list.clipboard", "メモ"),
        ("gearshape", "設定"),
    ]
    
    var body: some View {
        ZStack {
            HStack(spacing: 60) {
                ForEach(tab.indices, id: \.self) { index in
                    Button {
                        selection = index + 1
                    } label: {
                        VStack {
                            Image(systemName: tab[index].image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        }
                        .foregroundColor(index + 1 == selection ? .white.opacity(1.0) : .white.opacity(0.3))
                    }
                }
            }
            .custom3DBackground(width: 360, height: 64, cornerRadius: 50)
        }
        .padding(.horizontal)
    }
}
