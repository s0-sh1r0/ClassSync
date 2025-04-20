import SwiftUI

struct TableEditView: View {
    
    @Environment(\.dismiss) var dismiss
    
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
                    }
                    
                    Text("時間割編集")
                        .font(.title2)
                }
                
                VStack(spacing: 20) {
                    HStack {
                        Image(systemName: "highlighter")
                        Text("時間割名編集")
                        Spacer()
                    }
                    .padding(20)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    
                    HStack {
                        Image(systemName: "calendar")
                        Text("土日の授業")
                        Spacer()
                    }
                    .padding(20)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    
                    HStack {
                        Image(systemName: "list.number")
                        Text("1日の最大授業数")
                        Spacer()
                    }
                    .padding(20)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    
                    HStack {
                        Image(systemName: "watch.analog")
                        Text("授業時刻を編集")
                        Spacer()
                    }
                    .padding(20)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    
                    HStack {
                        Image(systemName: "trash")
                        Text("この時間割を削除")
                        Spacer()
                    }
                    .padding(20)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 2)
                    )
                }
                .font(.title3)
                
                Spacer()
            }
            .padding(.horizontal)
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    TableEditView()
}
