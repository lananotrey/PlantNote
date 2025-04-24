import SwiftUI

struct TermsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Terms of Use")
                    .font(.title)
                    .bold()
                    .padding(.bottom)
                
                Group {
                    Text("1. Acceptance of Terms")
                        .font(.headline)
                    Text("By accessing and using PlantNote, you accept and agree to be bound by the terms and provision of this agreement.")
                    
                    Text("2. Use License")
                        .font(.headline)
                    Text("Permission is granted to temporarily download one copy of PlantNote for personal, non-commercial transitory viewing only.")
                    
                    Text("3. Disclaimer")
                        .font(.headline)
                    Text("The materials on PlantNote are provided on an 'as is' basis. PlantNote makes no warranties, expressed or implied, and hereby disclaims and negates all other warranties including, without limitation, implied warranties or conditions of merchantability, fitness for a particular purpose, or non-infringement of intellectual property or other violation of rights.")
                    
                    Text("4. Limitations")
                        .font(.headline)
                    Text("In no event shall PlantNote or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption) arising out of the use or inability to use PlantNote.")
                }
                .padding(.bottom, 5)
            }
            .padding()
        }
        .navigationTitle("Terms of Use")
        .navigationBarTitleDisplayMode(.inline)
    }
}