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
                    Button {
                        rateApp()
                    } label: {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("Rate this app")
                        }
                    }
                    
                    Button {
                        shareApp()
                    } label: {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.blue)
                            Text("Share this app")
                        }
                    }
                    
                    NavigationLink {
                        TermsView()
                    } label: {
                        HStack {
                            Image(systemName: "doc.text")
                                .foregroundColor(.gray)
                            Text("Terms of Use")
                        }
                    }
                    
                    NavigationLink {
                        PrivacyView()
                    } label: {
                        HStack {
                            Image(systemName: "lock.shield")
                                .foregroundColor(.gray)
                            Text("Privacy Policy")
                        }
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
    
    private func rateApp() {
        guard let appStoreURL = URL(string: "https://apps.apple.com/app/idYOUR_APP_ID") else { return }
        UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
    }
    
    private func shareApp() {
        guard let appStoreURL = URL(string: "https://apps.apple.com/app/idYOUR_APP_ID") else { return }
        let activityVC = UIActivityViewController(activityItems: [appStoreURL], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootVC = window.rootViewController {
            activityVC.popoverPresentationController?.sourceView = rootVC.view
            rootVC.present(activityVC, animated: true)
        }
    }
}