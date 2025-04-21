import SwiftUI

struct TableRegistrationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var isFocusedKeyBoard: Bool
    
    @State var name = ""
    @State private var isSaturdayChecked = false
    @State private var isSundayChecked = false
    @State private var selectedNumber: Int = 5
    
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
                        
                        Text("時間割を登録")
                            .font(.title2)
                    }
                    
                    Text("時間割名")
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                    
                    ZStack(alignment : .leading) {
                        if name.isEmpty {
                            Text("新しい時間割")
                                .padding(.leading, 10)
                                .frame(maxWidth: .infinity,  alignment: .leading)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        TextField("", text: $name)
                            .padding(8) // ← 余白を追加
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
                    
                    HStack(spacing: 15) {
                        Text("土")
                        if isSundayChecked {
                            Image(systemName: "checkmark.square")
                                .foregroundColor(.white.opacity(0.5))
                        } else {
                            Image(systemName: isSaturdayChecked ? "checkmark.square" : "square")
                                .onTapGesture {
                                    isSaturdayChecked.toggle()
                                }
                        }

                        Text("/")

                        Text("日")
                        Image(systemName: isSundayChecked ? "checkmark.square" : "square")
                            .onTapGesture {
                                // 日曜をONにしたら土曜もONにする
                                if !isSundayChecked {
                                    isSundayChecked = true
                                    isSaturdayChecked = true
                                } else {
                                    isSundayChecked = false
                                }
                            }
                    }
                    .font(.title3)
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("1日の最大授業数")
                        .font(.title3)
                        .padding(.top, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Picker("選択してください", selection: $selectedNumber) {
                        ForEach(4...12, id: \.self) { number in
                            Text("\(number)")
                                .tag(number)
                                .foregroundColor(.white)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                    .border(Color.white)
                    
                    ConfilmButton()
                    
                    Spacer()
                }
                .padding(.horizontal)
                .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    TableRegistrationView()
}
