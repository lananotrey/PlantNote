import SwiftUI

struct PlantDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var plantManager: PlantManager
    let plant: Plant
    
    @State private var isEditing = false
    @State private var showingDeleteAlert = false
    @State private var showingShareSheet = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                HStack {
                    Text(plant.name)
                        .font(.title)
                        .bold()
                    Spacer()
                    Menu {
                        Button(role: .none) {
                            isEditing = true
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        
                        Button {
                            showingShareSheet = true
                        } label: {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                        
                        Button(role: .destructive) {
                            showingDeleteAlert = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle.fill")
                            .font(.title2)
                            .foregroundColor(.green)
                    }
                }
                .padding(.horizontal)
                
                // Care Information
                VStack(alignment: .leading, spacing: 15) {
                    InfoRow(title: "Last Watered", value: plant.lastWatered.formatted(.dateTime.day().month()), icon: "drop.fill")
                    InfoRow(title: "Watering Interval", value: "\(plant.wateringInterval) days", icon: "calendar")
                    if let fertilized = plant.lastFertilized {
                        InfoRow(title: "Last Fertilized", value: fertilized.formatted(.dateTime.day().month()), icon: "leaf.fill")
                    }
                    if let repotted = plant.lastRepotted {
                        InfoRow(title: "Last Repotted", value: repotted.formatted(.dateTime.day().month()), icon: "house.fill")
                    }
                }
                .padding()
                .background(Color("CardBackground"))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Notes
                if !plant.notes.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Notes")
                            .font(.headline)
                        Text(plant.notes)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color("CardBackground"))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .background(Color("BackgroundColor").ignoresSafeArea())
        .sheet(isPresented: $isEditing) {
            NavigationView {
                PlantEditView(plant: plant) { updatedPlant in
                    plantManager.updatePlant(updatedPlant)
                    dismiss()
                }
            }
        }
        .alert("Delete Plant", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                plantManager.deletePlant(plant)
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete \(plant.name)? This action cannot be undone.")
        }
        .sheet(isPresented: $showingShareSheet) {
            ShareSheet(activityItems: [createShareText()])
        }
    }
    
    private func createShareText() -> String {
        """
        Plant: \(plant.name)
        Watering Interval: Every \(plant.wateringInterval) days
        Last Watered: \(plant.lastWatered.formatted())
        Notes: \(plant.notes)
        """
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.green)
                .frame(width: 30)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.body)
            }
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}