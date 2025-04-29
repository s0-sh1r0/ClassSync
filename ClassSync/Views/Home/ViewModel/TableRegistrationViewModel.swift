import SwiftUI

class TableRegistrationViewModel: ObservableObject {
    @Published var name = ""
    @Published var isSaturdayChecked = false
    @Published var isSundayChecked = false
    @Published var selectedNumber: Int = 5
}
