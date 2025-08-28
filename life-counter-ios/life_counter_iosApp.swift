import SwiftUI

@main
struct life_counter_iosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LifeTotalModel())
                .onAppear(perform: {
                    UIApplication.shared.isIdleTimerDisabled = true
                })
                .onDisappear(perform: {
                    UIApplication.shared.isIdleTimerDisabled = false
                })
        }
    }
}
