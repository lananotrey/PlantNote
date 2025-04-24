import SwiftUI

struct EmptyStateView: View {
    @Binding var showingAddPlant: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "leaf.fill")
                .font(.system(size: 60))
                .foregroundColor(.green)
            
            Text("No Plants Yet")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Start adding your plants to track their care schedule")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            Button {
                showingAddPlant = true
            } label: {
                Text("Add Your First Plant")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.green)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}
