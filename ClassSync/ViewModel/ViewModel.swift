import SwiftUI

//class CoreDataModel: ObservableObject {
//    @Published var timetables: [Timetable] = []
//}

class ShowingViewModel: ObservableObject {
    @Published var isShowingTEView = false // TEView = TableEditView
    @Published var isShowingCRView = false // CRView = ClassRegistrationView
    @Published var isShowingTRView = false // TRView = TableRegistrationView
    @Published var isShowingCDView = false // CDView = ClassDetailView
}
