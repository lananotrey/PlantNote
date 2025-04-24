import SwiftUI

struct SettingsView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = true
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        NavigationView {
            List {
                Section("Appearance") {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                }
                
                Section("About") {
                    Button("Reset Onboarding") {
                        hasCompletedOnboarding = false
                    }
                    
                    Link(destination: URL(string: "https://example.com/privacy")!) {
                        Text("Privacy Policy")
                    }
                    
                    Link(destination: URL(string: "https://example.com/terms")!) {
                        Text("Terms of Service")
                    }
                }
                
                Section("App Info") {
                    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                        Text("Version \(version)")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}