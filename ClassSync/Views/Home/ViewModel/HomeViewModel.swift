import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var selectedDayOfWeek = "" // マス選択の初期値
    @Published var selectedPeriod = 1 // マス選択の初期値
    
    @Published var isShowingDialog = false
    @Published var selectedSchedule = "時間割A" // 表示中の時間割
    @Published var schedules = ["時間割A", "時間割B"] // ユーザーの登録した時間割一覧
    
    @Published var tablePeriod = 5 // 1日の最大授業数
    @Published var isSaturday = false // 土曜はあるか
    @Published var isSunday = false // 日曜はあるか
    
    @Published var isRegistered = true
    
    let weekdays = ["月", "火", "水", "木", "金", "土", "日"]

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
    
    var weekdayResult: String {
        getCurrentWeekday()
    }
}

