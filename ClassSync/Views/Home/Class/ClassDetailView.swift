import SwiftUI

struct ClassDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @Namespace private var animationNamespace
    @State private var selectedTab: String = "授業"
    let tabs = ["授業", "TODO", "メモ"]
    
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
                    
                    Text("授業を登録")
                        .font(.title2)
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
                                            RoundedRectangle(cornerRadius: 12)
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
                
                Spacer()
            }
            .padding(.horizontal)
            .foregroundColor(.white)
        }
    }
}

#Preview {
    ClassDetailView()
}
