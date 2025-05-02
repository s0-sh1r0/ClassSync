import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var selectedDayOfWeek = "" // マス選択の初期値
    @Published var selectedPeriod = 1 // マス選択の初期値
    
    @Published var isShowingDialog = false
    
    let weekdays = ["月", "火", "水", "木", "金", "土", "日"]
    
    var weekdayResult: String {
        getCurrentWeekday()
    }
}

