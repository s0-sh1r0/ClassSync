import SwiftUI
import CoreData

struct TopView: View {
    @FetchRequest(sortDescriptors: [])
    var contents: FetchedResults<Timetable>
    
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            if contents.isEmpty {
                StartView()
                    .tag(1)
            } else {
                HomeView()
                    .tag(1)
                    .id(UUID())
            }
            TaskView()
                .tag(2)
            MemoView()
                .tag(3)
            SettingView()
                .tag(4)
        }
        .overlay(alignment: .bottom) {
            CustomTabView(selection: $selection)
        }
        .navigationBarBackButtonHidden(true)
    }
}

