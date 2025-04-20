import SwiftUI

struct TableEditView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showAlert = false
    @State private var isDeleted = false
    
    var body: some View {
        NavigationStack {
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
                        NavigationLink(destination: TableNameEditView()) {
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
                        }

                        NavigationLink(destination: TableWeekendClassView()) {
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
                        }
                        
                        NavigationLink(destination: TableClassNumberView()) {
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
                        }
                        
                        NavigationLink(destination: TableTimeEditView()) {
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
                        }
                        
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
                            }
                            Button("キャンセル", role: .cancel) { }
                        } message: {
                            Text("この操作は取り消せません。")
                        }
                    }
                    .font(.title3)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    TableEditView()
}
