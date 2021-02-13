import Foundation

class TeaCollection {

    // MARK: Initialiser

    init() {
        if let data = defaults.data(forKey: "teaCollection") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Tea].self, from: data) {
                self.all = decoded
            }
        }
    }

    // MARK: Properties

    private let defaults = UserDefaults.standard

    // Allow setting only in private, read only when public
    private(set) var all: [Tea] = []

    // MARK: Methods

    public func add(_ tea: Tea) {
        all.append(tea)

        let encoder = JSONEncoder()
        if let data = try? encoder.encode(all) {
            defaults.set(data, forKey: "teaCollection")
        }
    }

    public func remove(at index: Int) {
        all.remove(at: index)
        
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(all) {
            defaults.set(data, forKey: "teaCollection")
        }
    }
}
