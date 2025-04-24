import SwiftUI

struct PlantsListView: View {
    @EnvironmentObject var plantManager: PlantManager
    @State private var showingAddPlant = false
    @State private var searchText = ""
    
    var filteredPlants: [Plant] {
        if searchText.isEmpty {
            return plantManager.plants
        }
        return plantManager.plants.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                if plantManager.plants.isEmpty {
                    EmptyStateView(showingAddPlant: $showingAddPlant)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(filteredPlants) { plant in
                                PlantCardView(plant: plant)
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            plantManager.deletePlant(plant)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("My Plants")
            .searchable(text: $searchText, prompt: "Search plants")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddPlant = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.green)
                    }
                }
            }
            .sheet(isPresented: $showingAddPlant) {
                AddPlantView(plantManager: plantManager)
            }
        }
    }
}