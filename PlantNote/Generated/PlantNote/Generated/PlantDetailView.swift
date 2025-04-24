import SwiftUI

struct PlantDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var plantManager: PlantManager
    let plant: Plant
    @State private var editedPlant: Plant
    
    init(plant: Plant) {
        self.plant = plant
        _editedPlant = State(initialValue: plant)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Plant Information") {
                    TextField("Plant Name", text: $editedPlant.name)
                    TextEditor(text: $editedPlant.notes)
                        .frame(height: 100)
                }
                
                Section("Care Schedule") {
                    HStack {
                        Text("Watering Interval")
                        Stepper("\(editedPlant.wateringInterval) days", value: $editedPlant.wateringInterval, in: 1...30)
                    }
                    
                    DatePicker("Last Watered", selection: $editedPlant.lastWatered, displayedComponents: .date)
                    
                    DatePicker("Last Fertilized", selection: Binding(
                        get: { editedPlant.lastFertilized ?? Date() },
                        set: { editedPlant.lastFertilized = $0 }
                    ), displayedComponents: .date)
                    
                    DatePicker("Last Repotted", selection: Binding(
                        get: { editedPlant.lastRepotted ?? Date() },
                        set: { editedPlant.lastRepotted = $0 }
                    ), displayedComponents: .date)
                }
            }
            .navigationTitle("Plant Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        plantManager.updatePlant(editedPlant)
                        dismiss()
                    }
                }
            }
        }
    }
}
