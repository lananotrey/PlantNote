import SwiftUI

struct PrivacyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Privacy Policy")
                    .font(.title)
                    .bold()
                    .padding(.bottom)
                
                Group {
                    Text("Information Collection and Use")
                        .font(.headline)
                    Text("PlantNote does not collect any personal information. All plant data is stored locally on your device.")
                    
                    Text("Data Storage")
                        .font(.headline)
                    Text("Your plant information and settings are stored locally on your device and are not transmitted to any external servers.")
                    
                    Text("Third-Party Services")
                        .font(.headline)
                    Text("PlantNote does not use any third-party services that collect user data.")
                    
                    Text("Changes to This Policy")
                        .font(.headline)
                    Text("We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.")
                    
                    Text("Contact Us")
                        .font(.headline)
                    Text("If you have any questions about this Privacy Policy, please contact us.")
                }
                .padding(.bottom, 5)
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
        .navigationBarTitleDisplayMode(.inline)
    }
}