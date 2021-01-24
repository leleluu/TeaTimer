import UIKit

class TeaCollectionViewController: UICollectionViewController {

    // MARK: Properties

    var teaCollection = [Tea]()

    // TODO: Remove dummy data
    let earlGrey = Tea(name: "Earl Grey", brewTime: 1)
    let rooibos = Tea(name: "Rooibos", brewTime: 2)
    let jasmine = Tea(name: "Jasmine", brewTime: 3)

    // MARK: ViewController life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        teaCollection.append(earlGrey)
        teaCollection.append(rooibos)
        teaCollection.append(jasmine)

        collectionView.backgroundColor = .white
        self.title = "Tea Collection"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTeaButtonTapped))
    
        collectionView.register(TeaCell.self, forCellWithReuseIdentifier: "cellid")

    }

    // MARK: Public methods

    func addTea(tea: Tea) {
        self.teaCollection.append(tea)
        collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teaCollection.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! TeaCell
        cell.contentView.layer.cornerRadius = 30
        cell.teaNameLabel.text = teaCollection[indexPath.item].name
        return cell
    }

    // MARK: Target action methods

    @objc private func addTeaButtonTapped() {
        let addTeaViewController = AddTeaViewController()
        addTeaViewController.onNewTeaAdded = addTea
        let addTeaNavigationController = UINavigationController(rootViewController: addTeaViewController)
        self.navigationController?.present(addTeaNavigationController, animated: true, completion: nil)

    }
}

