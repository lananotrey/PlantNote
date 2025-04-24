import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var plantManager: PlantManager
    
    var body: some View {
        TabView {
            PlantsListView()
                .tabItem {
                    Label("My Plants", systemImage: "leaf.fill")
                }
            
            StatisticsView()
                .tabItem {
                    Label("Statistics", systemImage: "chart.bar.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}