import SwiftUI

struct AddPlantView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var plantManager: PlantManager
    
    @State private var name = ""
    @State private var notes = ""
    @State private var wateringInterval = 7
    @State private var lastWatered = Date()
    @State private var lastFertilized: Date?
    @State private var lastRepotted: Date?
    
    var body: some View {
        NavigationView {
            Form {
                Section("Plant Information") {
                    TextField("Plant Name", text: $name)
                    TextEditor(text: $notes)
                        .frame(height: 100)
                }
                
                Section("Care Schedule") {
                    HStack {
                        Text("Watering Interval")
                        Stepper("\(wateringInterval) days", value: $wateringInterval, in: 1...30)
                    }
                    
                    DatePicker("Last Watered", selection: $lastWatered, displayedComponents: .date)
                    
                    DatePicker("Last Fertilized", selection: Binding(
                        get: { lastFertilized ?? Date() },
                        set: { lastFertilized = $0 }
                    ), displayedComponents: .date)
                    
                    DatePicker("Last Repotted", selection: Binding(
                        get: { lastRepotted ?? Date() },
                        set: { lastRepotted = $0 }
                    ), displayedComponents: .date)
                }
            }
            .navigationTitle("Add New Plant")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        let plant = Plant(
                            name: name,
                            notes: notes,
                            lastWatered: lastWatered,
                            lastFertilized: lastFertilized,
                            lastRepotted: lastRepotted,
                            wateringInterval: wateringInterval
                        )
                        plantManager.addPlant(plant)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}
