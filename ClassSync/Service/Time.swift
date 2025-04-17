import Foundation

func getCurrentWeekday() -> String {
    let now = Date()
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ja_JP") // 日本語ロケールを指定
    formatter.dateFormat = "E" // 曜日を省略形（例: 日, 月）で表示

    return formatter.string(from: now)
}
