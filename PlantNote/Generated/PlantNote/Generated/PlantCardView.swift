import SwiftUI

struct PlantCardView: View {
    let plant: Plant
    @State private var showingDetail = false
    @Binding var selectedTab: Int
    
    var body: some View {
        Button {
            showingDetail = true
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                Text(plant.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                VStack(alignment: .leading, spacing: 4) {
                    Label("Last watered: \(plant.lastWatered.formatted(.dateTime.day().month()))", systemImage: "drop.fill")
                    Text("Water in: \(daysUntilNextWatering) days")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color("CardBackground"))
            .cornerRadius(12)
            .shadow(radius: 2)
        }
        .sheet(isPresented: $showingDetail) {
            PlantDetailView(selectedTab: $selectedTab, plant: plant)
        }
    }
    
    private var daysUntilNextWatering: Int {
        let nextWatering = plant.lastWatered.addingTimeInterval(Double(plant.wateringInterval * 24 * 60 * 60))
        let difference = Calendar.current.dateComponents([.day], from: Date(), to: nextWatering)
        return difference.day ?? 0
    }
}