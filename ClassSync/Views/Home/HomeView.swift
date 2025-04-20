import SwiftUI

struct HomeView: View {

    @State private var isShowingTEView: Bool = false // TEView = TableEditView
    @State private var isShowingCRView: Bool = false //CRView = ClassRegistrationView
    
    @State private var selectedDayOfWeek: String = ""
    @State private var selectedPeriod: Int = 1
    
    var body: some View {
        let weekdays = ["月", "火", "水", "木", "金"]
        
        let weekdayResult = getCurrentWeekday()
        
        let verticalLength: CGFloat = 100 // テーブル1マスの縦の長さ
        let horizontalLength: CGFloat = 70 // テーブル1マスの横の長さ
        
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
                                Text("時間割")
                                    .bold()
                                    .font(.title)
                                    .foregroundStyle(Color.white)
                                Image(systemName: "chevron.down")
                                    .font(.title)
                                    .foregroundStyle(Color.white.opacity(0.7))
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
                            ForEach(weekdays, id: \.self) { day in
                                Text(day)
                                    .foregroundColor(day == weekdayResult ? .white.opacity(1.0) : .white.opacity(0.7))
                                    .frame(width: horizontalLength, height: 30)
                                    .bold()
                            }
                        }
                        
                        // 本体：行番号 + 5x6 マス
                        HStack(spacing: 0) {
                            // 行番号
                            VStack(spacing: 0) {
                                ForEach(1...6, id: \.self) { number in
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
                                    .frame(width: 40, height: verticalLength)
                                    .border(Color.white)
                                }
                            }
                            
                            // マス目
                            VStack(spacing: 0) {
                                ForEach(0..<6, id: \.self) { periodIndex in
                                    HStack(spacing: 0) {
                                        ForEach(0..<5, id: \.self) { dayIndex in
                                            let day = weekdays[dayIndex]
                                            let period = periodIndex + 1
                                            
                                            Button {
                                                print("🔴 DayOfWeek / Period: \(day) / \(period)限")
                                                print("🔴 selectedDayOfWeek / selectedPeriod: \(selectedDayOfWeek) / \(selectedPeriod)限")
                                                
                                                selectedDayOfWeek = day
                                                selectedPeriod = period
                                                
                                                print("🟠 DayOfWeek / Period: \(day) / \(period)限")
                                                print("🟠 selectedDayOfWeek / selectedPeriod: \(selectedDayOfWeek) / \(selectedPeriod)限")
                                                
                                                isShowingCRView = true
                                                print("🟢 DayOfWeek / Period: \(day) / \(period)限")
                                                print("🟢 selectedDayOfWeek / selectedPeriod: \(selectedDayOfWeek) / \(selectedPeriod)限")
                                            } label: {
                                                Rectangle()
                                                    .fill(Color.white.opacity(0.5))
                                                    .frame(width: horizontalLength, height: verticalLength)
                                                    .border(Color.white)
                                            }
                                        }
                                    }
                                }
                            }


                        }
                    }
                    .frame(width: geometry.size.width * 0.9)
                    .padding(.horizontal, geometry.size.width * 0.05)
                }
            }
            .fullScreenCover(isPresented: $isShowingTEView) {
                TableEditView()
            }
            .fullScreenCover(isPresented: $isShowingCRView) {
                ClassRegistrationView(subject: nil, dayOfWeek: $selectedDayOfWeek, period: $selectedPeriod)
            }
        }
    }
}

#Preview {
    HomeView()
}
