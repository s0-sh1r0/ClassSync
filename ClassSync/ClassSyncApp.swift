import SwiftUI

@main
struct ClassSyncApp: App {
    let persistenceController = persistencecontroller()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
