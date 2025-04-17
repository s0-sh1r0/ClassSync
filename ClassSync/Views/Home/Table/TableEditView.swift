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
                    
                    Text("時間割名")
                        .font(.title2)
                }
                
                Text("時間割名編集")
                Text("土日の授業")
                Text("1日の最大授業数")
                Text("授業時刻を編集")
                Text("この時間割を削除")
                
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
