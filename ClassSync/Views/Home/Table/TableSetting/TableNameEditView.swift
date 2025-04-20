import SwiftUI

struct TableNameEditView: View {
    @Environment(\.dismiss) var dismiss
    @FocusState private var isFocusedKeyBoard: Bool
    
    @State var inputTableName = ""
    
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
                        
                        Text("時間割名を編集")
                            .font(.title2)
                    }
                    
                    ZStack {
                        if inputTableName.isEmpty {
                            Text("時間割名を入力")
                                .padding(.leading, 10)
                                .frame(maxWidth: .infinity,  alignment: .leading)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        TextField("", text: $inputTableName)
                            .padding(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                            .focused($isFocusedKeyBoard)
                            .onAppear() {
                                DispatchQueue.main.async {
                                    isFocusedKeyBoard = true
                                }
                            }
                    }
                    
                    Spacer()
                    
                    ConfilmButton()
                    
                    Spacer()
                }
                .padding(.horizontal)
                .foregroundColor(.white)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TableNameEditView()
}
