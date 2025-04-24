import SwiftUI

struct PlantEditView: View {
    @Environment(\.dismiss) private var dismiss
    let plant: Plant
    let onSave: (Plant) -> Void
    
    @State private var editedName: String
    @State private var editedNotes: String
    @State private var editedWateringInterval: Int
    @State private var editedLastWatered: Date
    @State private var editedLastFertilized: Date?
    @State private var editedLastRepotted: Date?
    
    init(plant: Plant, onSave: @escaping (Plant) -> Void) {
        self.plant = plant
        self.onSave = onSave
        
        _editedName = State(initialValue: plant.name)
        _editedNotes = State(initialValue: plant.notes)
        _editedWateringInterval = State(initialValue: plant.wateringInterval)
        _editedLastWatered = State(initialValue: plant.lastWatered)
        _editedLastFertilized = State(initialValue: plant.lastFertilized)
        _editedLastRepotted = State(initialValue: plant.lastRepotted)
    }
    
    var body: some View {
        Form {
            Section("Plant Information") {
                TextField("Plant Name", text: $editedName)
                TextEditor(text: $editedNotes)
                    .frame(height: 100)
            }
            
            Section("Care Schedule") {
                HStack {
                    Text("Watering Interval")
                    Stepper("\(editedWateringInterval) days", value: $editedWateringInterval, in: 1...30)
                }
                
                DatePicker("Last Watered", selection: $editedLastWatered, displayedComponents: .date)
                
                DatePicker("Last Fertilized", selection: Binding(
                    get: { editedLastFertilized ?? Date() },
                    set: { editedLastFertilized = $0 }
                ), displayedComponents: .date)
                
                DatePicker("Last Repotted", selection: Binding(
                    get: { editedLastRepotted ?? Date() },
                    set: { editedLastRepotted = $0 }
                ), displayedComponents: .date)
            }
        }
        .navigationTitle("Edit Plant")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    let updatedPlant = Plant(
                        id: plant.id,
                        name: editedName,
                        notes: editedNotes,
                        lastWatered: editedLastWatered,
                        lastFertilized: editedLastFertilized,
                        lastRepotted: editedLastRepotted,
                        wateringInterval: editedWateringInterval
                    )
                    onSave(updatedPlant)
                }
                .disabled(editedName.isEmpty)
            }
        }
    }
}