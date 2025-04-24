import Foundation

class PlantManager: ObservableObject {
    @Published var plants: [Plant] = []
    private let savePath = FileManager.documentDirectory.appendingPathComponent("SavedPlants")
    
    init() {
        loadPlants()
    }
    
    func addPlant(_ plant: Plant) {
        plants.append(plant)
        savePlants()
    }
    
    func updatePlant(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index] = plant
            savePlants()
        }
    }
    
    func deletePlant(_ plant: Plant) {
        plants.removeAll { $0.id == plant.id }
        savePlants()
    }
    
    private func savePlants() {
        do {
            let data = try JSONEncoder().encode(plants)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save plants: \(error.localizedDescription)")
        }
    }
    
    private func loadPlants() {
        do {
            let data = try Data(contentsOf: savePath)
            plants = try JSONDecoder().decode([Plant].self, from: data)
        } catch {
            plants = []
        }
    }
}
