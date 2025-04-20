import SwiftUI

struct ClassRegistrationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var isFocusedKeyBoard: Bool
    
    let subject: String?
    @Binding var dayOfWeek: String
    @Binding var period: Int
    
    @State var inputSubject = ""
    @State var inputTeacherName = ""
    @State var inputRoom = ""
    
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
                        
                        Text("授業を登録")
                            .font(.title2)
                    }
                    Text("\(dayOfWeek)曜日の\(period)限目")
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                    
                    VStack(spacing: 15) {
                        ZStack {
                            if inputSubject.isEmpty {
                                Text("科目名を入力")
                                    .padding(.leading, 10)
                                    .frame(maxWidth: .infinity,  alignment: .leading)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            TextField("", text: $inputSubject)
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
                        
                        ZStack {
                            if inputTeacherName.isEmpty {
                                Text("教員名を入力")
                                    .padding(.leading, 10)
                                    .frame(maxWidth: .infinity,  alignment: .leading)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            TextField("", text: $inputTeacherName)
                                .padding(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.white, lineWidth: 1)
                                )
                        }
                        
                        ZStack {
                            if inputRoom.isEmpty {
                                Text("教室名を入力")
                                    .padding(.leading, 10)
                                    .frame(maxWidth: .infinity,  alignment: .leading)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            TextField("", text: $inputRoom)
                                .padding(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.white, lineWidth: 1)
                                )
                        }
                    }
                    .padding(.top, 10)
                    
                    ConfilmButton()
                    
                    Spacer()
                }
                .padding(.horizontal)
                .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    ClassRegistrationView(
        subject: nil,
        dayOfWeek: .constant("月"),
        period: .constant(2)
    )
}

