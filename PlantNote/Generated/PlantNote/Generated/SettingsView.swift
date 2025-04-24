import SwiftUI

struct SettingsView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = true
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    
    var body: some View {
        NavigationView {
            List {
                Section("Notifications") {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
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