import SwiftUI

struct PlantsListView: View {
    @EnvironmentObject var plantManager: PlantManager
    @Binding var showingAddPlant: Bool
    @State private var searchText = ""
    @Binding var selectedTab: Int
    
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
                                PlantCardView(plant: plant, selectedTab: $selectedTab)
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
        }
    }
}