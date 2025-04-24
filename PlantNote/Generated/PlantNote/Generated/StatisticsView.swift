import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var plantManager: PlantManager
    
    var body: some View {
        NavigationView {
            List {
                Section("General Statistics") {
                    StatRow(title: "Total Plants", value: "\(plantManager.plants.count)")
                    StatRow(title: "Plants Needing Water", value: "\(plantsNeedingWater)")
                    StatRow(title: "Last Added Plant", value: lastAddedPlant)
                }
                
                Section("Care Overview") {
                    StatRow(title: "Average Watering Interval", value: "\(averageWateringInterval) days")
                    StatRow(title: "Most Common Interval", value: "\(mostCommonInterval) days")
                }
            }
            .navigationTitle("Statistics")
        }
    }
    
    private var plantsNeedingWater: Int {
        plantManager.plants.filter { plant in
            let nextWatering = plant.lastWatered.addingTimeInterval(Double(plant.wateringInterval * 24 * 60 * 60))
            return Date() >= nextWatering
        }.count
    }
    
    private var lastAddedPlant: String {
        plantManager.plants.last?.name ?? "No plants yet"
    }
    
    private var averageWateringInterval: Int {
        guard !plantManager.plants.isEmpty else { return 0 }
        let total = plantManager.plants.reduce(0) { $0 + $1.wateringInterval }
        return total / plantManager.plants.count
    }
    
    private var mostCommonInterval: Int {
        let intervals = plantManager.plants.map { $0.wateringInterval }
        let grouped = Dictionary(grouping: intervals) { $0 }
        return grouped.max(by: { $0.value.count < $1.value.count })?.key ?? 0
    }
}

struct StatRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}