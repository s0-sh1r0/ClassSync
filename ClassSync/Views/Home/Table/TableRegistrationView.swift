import SwiftUI
import CoreData

struct TableRegistrationView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @StateObject private var registrationModel = TableRegistrationViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var isFocusedKeyBoard: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Background()
                
                VStack {
                    // ページタイトル
                    PageTitle
                    
                    Text("時間割名")
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                    
                    NameTextField // 時間割名入力欄
                    
                    weekendCheck // 土日チェック
                    
                    Text("1日の最大授業数")
                        .font(.title3)
                        .padding(.top, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    NumberPicker // 選択
                    
                    ConfilmButton {
                        addContent()
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .foregroundStyle(.white)
            }
        }
    }
    
    func addContent() {
        let newContent = Timetable(context: viewContext)
        
        newContent.name = registrationModel.name
        newContent.isOnSaturday = registrationModel.isSaturdayChecked
        newContent.isOnSunday = registrationModel.isSundayChecked
        newContent.maximumNumberOfLessons = Int16(registrationModel.selectedNumber)
        
        dismiss()
        
        do {
            try viewContext.save()
        } catch {
            fatalError("セーブに失敗")
        }
        
        print("\(registrationModel.name)")
        print("\(registrationModel.isSaturdayChecked)")
        print("\(registrationModel.isSundayChecked)")
        print("\(registrationModel.selectedNumber)")
    }
}

extension TableRegistrationView {
    private var PageTitle: some View {
        ZStack {
            HStack {
                CloseButton {
                    dismiss()
                }
                Spacer()
            }
            
            TitleText(text: "時間割を登録")
        }
    }
    
    private var NameTextField: some View {
        ZStack(alignment : .leading) {
            if registrationModel.name.isEmpty {
                Text("新しい時間割")
                    .padding(.leading, 10)
                    .frame(maxWidth: .infinity,  alignment: .leading)
                    .foregroundColor(.white.opacity(0.7))
            }
            TextField("", text: $registrationModel.name)
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
    }
    
    private var weekendCheck: some View {
        HStack(spacing: 15) {
            Text("土")
            if registrationModel.isSundayChecked {
                Image(systemName: "checkmark.square")
                    .foregroundColor(.white.opacity(0.5))
            } else {
                Image(systemName: registrationModel.isSaturdayChecked ? "checkmark.square" : "square")
                    .onTapGesture {
                        registrationModel.isSaturdayChecked.toggle()
                    }
            }

            Text("/")

            Text("日")
            Image(systemName: registrationModel.isSundayChecked ? "checkmark.square" : "square")
                .onTapGesture {
                    // 日曜をONにしたら土曜もONにする
                    if !registrationModel.isSundayChecked {
                        registrationModel.isSundayChecked = true
                        registrationModel.isSaturdayChecked = true
                    } else {
                        registrationModel.isSundayChecked = false
                    }
                }
        }
        .font(.title3)
        .padding(.top, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var NumberPicker: some View  {
        Picker("選択してください", selection: $registrationModel.selectedNumber) {
            ForEach(4...12, id: \.self) { number in
                Text("\(number)")
                    .tag(number)
                    .foregroundColor(.white)
            }
        }
        .pickerStyle(.wheel)
        .frame(height: 150)
        .border(Color.white)
    }
}

#Preview {
    TableRegistrationView()
}
