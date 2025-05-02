import SwiftUI
import CoreData

struct HomeView: View {
    @FetchRequest(
        entity: Timetable.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Timetable.name, ascending: true)]
    ) var fetchedTable: FetchedResults<Timetable>

    
    @StateObject private var viewModel = HomeViewModel()
    @StateObject private var showingModel = ShowingViewModel()
    @State var selectedSchedule: String = ""
    @State var schedules: [String] = []
    @State var tablePeriod = 5 // 1日の最大授業数
    @State var isSaturday = false // 土曜はあるか
    @State var isSunday = false // 日曜はあるか
    
    @State var isRegistered = true
    
    var numberOfDays: Int {
        if isSunday {
            return 7
        } else if isSaturday {
            return 6
        } else {
            return 5
        }
    }
    
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
    
    var body: some View {
        NavigationStack {
            ZStack {
                Background()
                
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        // ページタイトル
                        HomeTitle

                        // 曜日ヘッダー
                        WeekHeader
                        
                        // 時間割表
                        TableView
                    }
                    .frame(width: geometry.size.width * 0.9)
                    .padding(.horizontal, geometry.size.width * 0.05)
                    .confirmationDialog("表示する時間割を選択", isPresented: $viewModel.isShowingDialog, titleVisibility: .visible) {
                        // 時間割選択肢
                        ForEach(schedules, id: \.self) { schedule in
                            Button(schedule) {
                                selectedSchedule = schedule
                            }
                        }

                        // 新規作成ボタン
                        Button("新しい時間割を作成", role: .none) {
                            showingModel.isShowingTRView.toggle()
                        }

                        Button("キャンセル", role: .cancel) {
                            // 何もしない（閉じるだけ）
                        }
                    }
                }
            }
            .onAppear {
                let names = fetchedTable.map { $0.name ?? "無名" }
                schedules = names
                if let first = names.first {
                    selectedSchedule = first
                }
                updateTableSettings()
            }
            .onChange(of: fetchedTable.map { $0.objectID }) {
                updateTableSettings()
            }
            .onChange(of: selectedSchedule) {
                updateTableSettings()
            }
            .fullScreenCover(isPresented: $showingModel.isShowingTEView) {
                TableEditView()
            }
            .fullScreenCover(isPresented: $showingModel.isShowingCRView) {
                ClassRegistrationView(subject: nil, dayOfWeek: $viewModel.selectedDayOfWeek, period: $viewModel.selectedPeriod)
            }
            .fullScreenCover(isPresented: $showingModel.isShowingTRView) {
                TableRegistrationView()
            }
            .fullScreenCover(isPresented: $showingModel.isShowingCDView) {
                ClassDetailView(/*subject: .constant("科目名"), dayOfWeek: day, period: period*/)
            }
        }
    }
    
    private var TableView: some View {
        ScrollView {
            HStack(spacing: 0) {
                // 行番号
                LineNumber
                
                // マス目
                Table
            }
        }
        .frame(height: 600)
    }
    
    @ViewBuilder
    private func tableButton(day: String, period: Int) -> some View {
        Button {
            handleTableSelection(day: day, period: period)
        } label: {
            ZStack {
                Rectangle()
                    .fill(Color.white.opacity(0.5))
                    .frame(width: currentWidth, height: currentHeight)
                    .border(Color.white)
                
                TableItemView(width: currentWidth, height: currentHeight, color: .gray)
            }
        }
    }
    
    private func updateTableSettings() {
        if let selectedTable = fetchedTable.first(where: { $0.name == selectedSchedule }) {
            tablePeriod = Int(selectedTable.maximumNumberOfLessons)
            isSaturday = selectedTable.isOnSaturday
            isSunday = selectedTable.isOnSunday
        }
    }


    private func handleTableSelection(day: String, period: Int) {
        viewModel.selectedDayOfWeek = day
        viewModel.selectedPeriod = period
        
        if isRegistered {
            showingModel.isShowingCDView = true
        } else {
            showingModel.isShowingCRView = true
        }
    }

}

extension HomeView {
    private var HomeTitle: some View {
        HStack {
            Button {
                showingModel.isShowingTEView.toggle()
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
                viewModel.isShowingDialog.toggle()
            }
            
            Spacer()
            
            Image(systemName: "square.and.arrow.up")
                .font(.title)
                .foregroundStyle(Color.white)
        }
    }
    
    private var WeekHeader: some View {
        HStack(spacing: 0) {
            Text("")
                .frame(width: 40, height: 30)
            ForEach(viewModel.weekdays.prefix(numberOfDays), id: \.self) { day in
                Text(day)
                    .foregroundColor(day == viewModel.weekdayResult ? .white.opacity(1.0) : .white.opacity(0.7))
                    .frame(width: currentWidth, height: 30)
                    .bold()
            }
        }
    }
    
    private var LineNumber: some View {
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
    }
    
    private var Table: some View {
        VStack(spacing: 0) {
            ForEach(0..<tablePeriod, id: \.self) { periodIndex in
                HStack(spacing: 0) {
                    ForEach(0..<numberOfDays, id: \.self) { dayIndex in
                        let day = viewModel.weekdays[dayIndex]
                        let period = periodIndex + 1
                        
                        tableButton(day: day, period: period)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
