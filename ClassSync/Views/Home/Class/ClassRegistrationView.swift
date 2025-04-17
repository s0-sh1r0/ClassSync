import SwiftUI

struct ClassRegistrationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let subject: String?
    let dayOfWeek: String
    let period: Int
    
    var body: some View {
        ZStack {
//            Background()
            Color.blue
                .ignoresSafeArea()
            
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
                    
                    Text("時間を登録")
                        .font(.title2)
                }
                Text("\(dayOfWeek)の\(period)限")
                Text("科目名を入力")
                Text("教員を入力")
                Text("教室を入力")
                Text("確定")
                
                Spacer()
            }
            .padding(.horizontal)
            .foregroundColor(.white)
        }
    }
}

#Preview {
    ClassRegistrationView(subject: nil, dayOfWeek: "月", period: 2)
}
