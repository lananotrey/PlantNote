import SwiftUI

struct ContentView: View {
    @StateObject private var plantManager = PlantManager()
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        if hasCompletedOnboarding {
            MainTabView()
                .environmentObject(plantManager)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        } else {
            OnboardingView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}