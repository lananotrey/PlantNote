import SwiftUI

struct ContentView: View {
    @StateObject private var plantManager = PlantManager()
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    init() {
    }
    
    var body: some View {
        if hasCompletedOnboarding {
            MainTabView()
                .environmentObject(plantManager)
        } else {
            OnboardingView()
        }
    }
}