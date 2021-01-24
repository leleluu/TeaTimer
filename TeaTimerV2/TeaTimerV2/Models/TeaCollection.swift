import Foundation

class TeaCollection {

    // MARK: Properties

    // Allow setting only in private, read only when public
    private(set) var all: [Tea] = []

    // MARK: Methods

    public func add(_ tea: Tea) {
        all.append(tea)
    }
}
