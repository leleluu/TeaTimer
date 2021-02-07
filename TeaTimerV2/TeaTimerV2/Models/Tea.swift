import Foundation

struct Tea: Codable {
    let name: String
    let brewTimeInSeconds: Int

    init(name: String, brewTimeInMinutes: Int) {
        self.name = name
        self.brewTimeInSeconds = brewTimeInMinutes * 60
    }
}
