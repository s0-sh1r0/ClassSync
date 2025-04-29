import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @StateObject private var showingModel = ShowingViewModel()
    
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
                        ForEach(viewModel.schedules, id: \.self) { schedule in
                            Button(schedule) {
                                viewModel.selectedSchedule = schedule
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
                    .frame(width: viewModel.currentWidth, height: viewModel.currentHeight)
                    .border(Color.white)
                
                TableItemView(width: viewModel.currentWidth, height: viewModel.currentHeight, color: .gray)
            }
        }
    }

    private func handleTableSelection(day: String, period: Int) {
        viewModel.selectedDayOfWeek = day
        viewModel.selectedPeriod = period
        
        if viewModel.isRegistered {
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
                Text(viewModel.selectedSchedule)
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
            ForEach(viewModel.weekdays.prefix(viewModel.numberOfDays), id: \.self) { day in
                Text(day)
                    .foregroundColor(day == viewModel.weekdayResult ? .white.opacity(1.0) : .white.opacity(0.7))
                    .frame(width: viewModel.currentWidth, height: 30)
                    .bold()
            }
        }
    }
    
    private var LineNumber: some View {
        VStack(spacing: 0) {
            ForEach(1...viewModel.tablePeriod, id: \.self) { number in
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
                .frame(width: 40, height: viewModel.currentHeight)
                .border(Color.white)
            }
        }
    }
    
    private var Table: some View {
        VStack(spacing: 0) {
            ForEach(0..<viewModel.tablePeriod, id: \.self) { periodIndex in
                HStack(spacing: 0) {
                    ForEach(0..<viewModel.numberOfDays, id: \.self) { dayIndex in
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
