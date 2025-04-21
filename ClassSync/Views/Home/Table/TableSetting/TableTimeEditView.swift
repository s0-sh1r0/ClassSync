import SwiftUI

struct TableTimeEditView: View {
    @Environment(\.dismiss) var dismiss

    @State private var periodTimes: [(start: Date, end: Date)] = Array(
        repeating: (start: Date(), end: Date()), count: 6
    )

    @State private var selectedPeriodIndex: Int? = nil
    @State private var isShowingPopover: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Background()

                VStack {
                    // ヘッダー
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

                    // 各時限の設定ボタン
                    VStack(spacing: 20) {
                        ForEach(0..<6, id: \.self) { period in
                            Button {
                                selectedPeriodIndex = period
                                isShowingPopover = true
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
                            // popoverを各ボタンに関連付け
                            .popover(isPresented: Binding(
                                get: { isShowingPopover && selectedPeriodIndex == period },
                                set: { newValue in
                                    if !newValue { isShowingPopover = false }
                                }
                            )) {
                                VStack(spacing: 20) {
                                    Text("開始時刻")
                                        .font(.headline)

                                    DatePicker("", selection: Binding(
                                        get: { periodTimes[period].start },
                                        set: { periodTimes[period].start = $0 }
                                    ), displayedComponents: .hourAndMinute)
                                        .datePickerStyle(.wheel)
                                        .labelsHidden()

                                    Text("終了時刻")
                                        .font(.headline)

                                    DatePicker("", selection: Binding(
                                        get: { periodTimes[period].end },
                                        set: { periodTimes[period].end = $0 }
                                    ), displayedComponents: .hourAndMinute)
                                        .datePickerStyle(.wheel)
                                        .labelsHidden()

                                    Button("閉じる") {
                                        isShowingPopover = false
                                    }
                                    .padding(.top)
                                }
                                .padding()
                                .frame(width: 300)
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

    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

#Preview {
    TableTimeEditView()
}
