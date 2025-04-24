import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var plantManager: PlantManager
    @State private var selectedTab = 0
    @State private var showingAddPlant = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PlantsListView(showingAddPlant: $showingAddPlant, selectedTab: $selectedTab)
                .tabItem {
                    Label("My Plants", systemImage: "leaf.fill")
                }
                .tag(0)
            
            StatisticsView()
                .tabItem {
                    Label("Statistics", systemImage: "chart.bar.fill")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(2)
        }
        .sheet(isPresented: $showingAddPlant) {
            AddPlantView(plantManager: plantManager, selectedTab: $selectedTab)
        }
    }
}