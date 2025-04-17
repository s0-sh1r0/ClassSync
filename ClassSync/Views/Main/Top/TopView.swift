import SwiftUI

struct TopView: View {
    
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tag(1)
            TaskView()
                .tag(2)
            MemoView()
                .tag(3)
            SettingView()
                .tag(4)
            StartView()
                .tag(5)
        }
        .overlay(alignment: .bottom) {
            CustomTabView(selection: $selection)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TopView()
}
