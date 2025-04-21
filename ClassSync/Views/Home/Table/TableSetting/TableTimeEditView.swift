import SwiftUI

struct TableTimeEditView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var periodTimes: [(start: Date, end: Date)] = Array(repeating: (start: Date(), end: Date()), count: 6)
    @State private var selectedPeriodIndex: Int? = nil
    @State private var isShowingTimePicker = false
    
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
                        
                        Text("授業時刻を編集")
                            .font(.title2)
                    }
                    
                    VStack(spacing: 20) {
                        ForEach(0..<6, id: \.self) { period in
                            Button {
                                selectedPeriodIndex = period
                                isShowingTimePicker = true
                            } label: {
                                HStack {
                                    Text("\(period + 1)限")
                                    Spacer()
                                    Text("\(formattedTime(periodTimes[period].start)) - \(formattedTime(periodTimes[period].end))")
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
                    
                    Spacer()
                    
                    ConfilmButton()
                    
                    Spacer()
                }
                .padding(.horizontal)
                .foregroundColor(.white)
            }
        }
        .sheet(isPresented: $isShowingTimePicker) {
            if let index = selectedPeriodIndex {
                TimePickerSheet(
                    startTime: $periodTimes[index].start,
                    endTime: $periodTimes[index].end
                )
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

struct TimePickerSheet: View {
    @Binding var startTime: Date
    @Binding var endTime: Date
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("開始時刻")
                DatePicker("開始", selection: $startTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                
                Text("終了時刻")
                DatePicker("終了", selection: $endTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                
                Button("完了") {
                    dismiss()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }
}

#Preview {
    TableTimeEditView()
}
