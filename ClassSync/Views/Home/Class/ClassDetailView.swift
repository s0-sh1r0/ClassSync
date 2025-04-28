import SwiftUI

struct ClassDetailView: View {
    @Environment(\.dismiss) var dismiss
    
//    @Binding var subject: String
//    @Binding var dayOfWeek: String
//    @Binding var period: Int
    
    @Namespace private var animationNamespace
    @State private var selectedTab: String = "授業"
    let tabs = ["授業", "TODO", "メモ"]
    let classColors: [Color] = [
        .red, .orange, .yellow, .green, .blue,
        .indigo, .purple, .pink, .gray, .teal
    ]
    @State private var selectedColorIndex: Int = 0
    
    var body: some View {
        ZStack {
            Background()
            
            VStack {
                ZStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title2)
                        }
                        Spacer()
                        
                        Image(systemName: "trash")
                            .font(.title2)
                    }
                    
//                    Text(subject)
//                        .font(.title2)
                }
                
                HStack(spacing: 0) {
                    ForEach(tabs, id: \.self) { tab in
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                selectedTab = tab
                            }
                        }) {
                            Text(tab)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 5)
                                .background(
                                    ZStack {
                                        if selectedTab == tab {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.white)
                                                .matchedGeometryEffect(id: "tabBackground", in: animationNamespace)
                                                .shadow(color: .gray.opacity(0.4), radius: 3, x: 0, y: 2)
                                        }
                                    }
                                )
                                .foregroundColor(.black)
                        }
                        
                        if tab != tabs.last {
                            Divider()
                                .frame(width: 1, height: 24)
                                .background(Color.gray.opacity(0.3))
                        }
                    }
                }
                .padding(4)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding()
                
                VStack(spacing: 50) {
                    HStack {
                        Image(systemName: "book.pages")
                        Text("科目名")
                        Spacer()
                    }
                    .padding(.leading, 20)
                    .padding(.top, 40)
                    HStack {
                        Image(systemName: "location")
                        Text("教室名")
                        Spacer()
                    }
                    .padding(.leading, 20)
                    HStack {
                        Image(systemName: "person")
                        Text("教員名")
                        Spacer()
                    }
                    .padding(.leading, 20)
                    .padding(.bottom, 40)
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
                .font(.title3)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(classColors[selectedColorIndex])
                )
                
                VStack(spacing: 14) {
                    // 上段
                    HStack(spacing: 40) {
                        ForEach(0..<5) { index in
                            colorCircle(index: index)
                        }
                    }

                    // 下段
                    HStack(spacing: 40) {
                        ForEach(5..<10) { index in
                            colorCircle(index: index)
                        }
                    }
                }
                .padding(8)
                
                HStack(spacing: 50) {
                    VStack {
                        Text("出席")
                        Text("0")
                    }
                    VStack {
                        Text("欠席")
                        Text("0")
                    }
                    VStack {
                        Text("遅刻")
                        Text("0")
                    }
                    VStack {
                        Text("休講")
                        Text("0")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 2)
                )
                .padding(.top, 5)
                
                Spacer()
            }
            .padding(.horizontal)
            .foregroundColor(.white)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    func colorCircle(index: Int) -> some View {
        Circle()
            .fill(classColors[index])
            .frame(width: 30, height: 30)
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: selectedColorIndex == index ? 3 : 0)
            )
            .onTapGesture {
                selectedColorIndex = index
            }
    }
}

#Preview {
    ClassDetailView(/*subject: .constant("科目名"), dayOfWeek: .constant("火"), period: .constant(3)*/)
}
