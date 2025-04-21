import SwiftUI

struct TableWeekendClassView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var isSaturdayChecked = false
    @State private var isSundayChecked = false
    
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
                        
                        Text("土日の授業")
                            .font(.title2)
                    }
                    
                    HStack(spacing: 15) {
                        Text("土曜日")
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

                        Text("日曜日")
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
    TableWeekendClassView()
}
