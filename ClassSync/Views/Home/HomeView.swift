import SwiftUI

struct HomeView: View {

    @State private var isShowingTEView: Bool = false // TEView = TableEditView
    @State private var isShowingCRView: Bool = false // CRView = ClassRegistrationView
    @State private var isShowingTRView: Bool = false // TRView = TableRegistrationView
    @State private var isShowingCDView: Bool = false // CDView = ClassDetailView
    
    @State private var selectedDayOfWeek: String = ""
    @State private var selectedPeriod: Int = 1
    
    @State private var isShowingDialog = false
    @State private var selectedSchedule = "時間割A"
    @State private var schedules = ["時間割A", "時間割B"]
    
    @State private var tablePeriod: Int = 5 // 1日の最大授業数
    @State private var isSaturday: Bool = false // 土曜はあるか
    @State private var isSunday: Bool = false // 日曜はあるか
    
    var numberOfDays: Int { // 授業がある日数
        if isSunday {
            return 7
        } else if isSaturday {
            return 6
        } else {
            return 5
        }
    }
    
    @State private var IsRegistered: Bool = true
    
    var body: some View {
        let weekdays = ["月", "火", "水", "木", "金", "土", "日"]
        
        let weekdayResult = getCurrentWeekday()
        
        var currentWidth: CGFloat {
            switch numberOfDays {
            case 6:
                return 58
            case 7:
                return 50
            default:
                return 70
            }
        }
        
        var currentHeight: CGFloat {
            switch tablePeriod {
            case 4:
                return 150
            case 5:
                return 120
            default:
                return 100
            }
        }
        
        
        NavigationStack {
            ZStack {
                Background()
                
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        HStack {
                            Button {
                                isShowingTEView.toggle()
                            } label: {
                                Image(systemName: "gearshape.2.fill")
                                    .font(.title)
                                    .foregroundStyle(Color.white)
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 0) {
                                Text(selectedSchedule)
                                    .bold()
                                    .font(.title)
                                    .foregroundStyle(Color.white)
                                Image(systemName: "chevron.down")
                                    .font(.title)
                                    .foregroundStyle(Color.white.opacity(0.7))
                            }
                            .onTapGesture {
                                isShowingDialog.toggle()
                            }
                            
                            Spacer()
                            
                            Image(systemName: "square.and.arrow.up")
                                .font(.title)
                                .foregroundStyle(Color.white)
                        }
                        // 曜日ヘッダー
                        HStack(spacing: 0) {
                            Text("")
                                .frame(width: 40, height: 30)
                            ForEach(weekdays.prefix(numberOfDays), id: \.self) { day in
                                Text(day)
                                    .foregroundColor(day == weekdayResult ? .white.opacity(1.0) : .white.opacity(0.7))
                                    .frame(width: currentWidth, height: 30)
                                    .bold()
                            }
                        }
                        
                        // 本体：行番号
                        ScrollView {
                            HStack(spacing: 0) {
                                // 行番号
                                VStack(spacing: 0) {
                                    ForEach(1...tablePeriod, id: \.self) { number in
                                        VStack {
                                            Text("00:00")
                                                .font(.caption)
                                                .foregroundStyle(Color.white)
                                            Text("\(number)")
                                                .bold()
                                                .foregroundStyle(Color.white)
                                                .padding(.vertical, 15)
                                            Text("00:00")
                                                .font(.caption)
                                                .foregroundStyle(Color.white)
                                        }
                                        .frame(width: 40, height: currentHeight)
                                        .border(Color.white)
                                    }
                                }
                                
                                // マス目
                                VStack(spacing: 0) {
                                    ForEach(0..<tablePeriod, id: \.self) { periodIndex in
                                        HStack(spacing: 0) {
                                            ForEach(0..<numberOfDays, id: \.self) { dayIndex in
                                                let day = weekdays[dayIndex]
                                                let period = periodIndex + 1
                                                
                                                Button {
                                                    selectedDayOfWeek = day
                                                    selectedPeriod = period
                                                    
                                                    if IsRegistered {
                                                        isShowingCDView = true
                                                    } else {
                                                        isShowingCRView = true
                                                    }
                                                } label: {
                                                    ZStack {
                                                        Rectangle().fill(Color.white.opacity(0.5))
                                                            .frame(width: currentWidth, height: currentHeight)
                                                            .border(Color.white)
                                                        
                                                        TableItemView(width: currentWidth, height: currentHeight, color: .gray)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .frame(height: 600)
                    }
                    .frame(width: geometry.size.width * 0.9)
                    .padding(.horizontal, geometry.size.width * 0.05)
                    .confirmationDialog("表示する時間割を選択", isPresented: $isShowingDialog, titleVisibility: .visible) {
                        // 時間割選択肢
                        ForEach(schedules, id: \.self) { schedule in
                            Button(schedule) {
                                selectedSchedule = schedule
                            }
                        }

                        // 新規作成ボタン
                        Button("新しい時間割を作成", role: .none) {
                            isShowingTRView.toggle()
                        }

                        Button("キャンセル", role: .cancel) {
                            // 何もしない（閉じるだけ）
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $isShowingTEView) {
                TableEditView()
            }
            .fullScreenCover(isPresented: $isShowingCRView) {
                ClassRegistrationView(subject: nil, dayOfWeek: $selectedDayOfWeek, period: $selectedPeriod)
            }
            .fullScreenCover(isPresented: $isShowingTRView) {
                TableRegistrationView()
            }
            .fullScreenCover(isPresented: $isShowingCDView) {
                ClassDetailView(/*subject: .constant("科目名"), dayOfWeek: day, period: period*/)
            }
        }
    }
}

#Preview {
    HomeView()
}
