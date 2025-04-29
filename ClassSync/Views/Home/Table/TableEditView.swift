import SwiftUI

struct TableEditView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showAlert = false
    @State private var isDeleted = false
    @State private var navigateToTopView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Background()
                
                VStack {
                    // ページタイトル
                    PageTitle
                    
                    // 各設定への遷移ボタン
                    VStack(spacing: 20) {
                        NavigationActionButton(destination: TableNameEditView(), systemImageName: "highlighter", labelText: "時間割名編集")
                        
                        NavigationActionButton(destination: TableWeekendClassView(), systemImageName: "calendar", labelText: "土日の授業")
                        
                        NavigationActionButton(destination: TableClassNumberView(), systemImageName: "list.number", labelText: "1日の最大授業数")
                        
                        NavigationActionButton(destination: TableTimeEditView(), systemImageName: "watch.analog", labelText: "授業時刻を編集")
                        
                        DeleteButton
                    }
                    .font(.title3)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .foregroundStyle(.white)
            }
        }
    }
    
    struct NavigationActionButton<Destination: View>: View {
        var destination: Destination
        var systemImageName: String
        var labelText: String

        var body: some View {
            NavigationLink(destination: destination) {
                HStack {
                    Image(systemName: systemImageName)
                    Text(labelText)
                    Spacer()
                }
                .padding(20)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 2)
                )
            }
        }
    }
}

extension TableEditView {
    private var PageTitle: some View {
        ZStack {
            HStack {
                CloseButton {
                    dismiss()
                }
                Spacer()
            }
            TitleText(text: "時間割編集")
        }
    }
    
    private var DeleteButton: some View {
        VStack {
            Button(role: .destructive) {
                showAlert = true
            } label: {
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
            .alert("本当に削除しますか？", isPresented: $showAlert) {
                Button("削除", role: .destructive) {
                    // 削除処理
                    isDeleted = true
                    navigateToTopView = true
                }
                Button("キャンセル", role: .cancel) { }
            } message: {
                Text("この操作は取り消せません。")
            }
        }
        .navigationDestination(isPresented: $navigateToTopView) {
            TopView()
        }
    }
}

#Preview {
    TableEditView()
}
