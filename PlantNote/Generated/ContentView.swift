import Foundation

struct Plant: Identifiable, Codable {
    let id: UUID
    var name: String
    var notes: String
    var lastWatered: Date
    var lastFertilized: Date?
    var lastRepotted: Date?
    var wateringInterval: Int // in days
    
    init(id: UUID = UUID(), name: String, notes: String, lastWatered: Date = Date(), lastFertilized: Date? = nil, lastRepotted: Date? = nil, wateringInterval: Int) {
        self.id = id
        self.name = name
        self.notes = notes
        self.lastWatered = lastWatered
        self.lastFertilized = lastFertilized
        self.lastRepotted = lastRepotted
        self.wateringInterval = wateringInterval
    }
}
