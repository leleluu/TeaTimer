import UIKit

class ViewController: UIViewController {

    //TODO: Remove dummy data
    let earlGrey = Tea(name: "Earl Grey", brewTime: 1)
    let rooibos = Tea(name: "Rooibos", brewTime: 2)
    let jasmine = Tea(name: "Jasmine", brewTime: 3)

    var teaCollection = [Tea]()

    override func viewDidLoad() {
        super.viewDidLoad()
        teaCollection.append(earlGrey)
        teaCollection.append(rooibos)
        teaCollection.append(jasmine)
    }
}

