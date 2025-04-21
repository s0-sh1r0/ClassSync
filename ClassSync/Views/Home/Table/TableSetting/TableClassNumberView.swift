import SwiftUI

struct TableClassNumberView: View {
    @Environment(\.dismiss) var dismiss
    
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
                        
                        Text("1日の最大授業数")
                            .font(.title2)
                    }
                    
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
    TableClassNumberView()
}
