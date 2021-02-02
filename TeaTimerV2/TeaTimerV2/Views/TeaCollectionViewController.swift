import UIKit

class TeaCollectionViewController: UICollectionViewController {

    // MARK: Properties

    var teaCollection = TeaCollection()

    // MARK: ViewController life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        self.title = "Tea Collection"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTeaButtonTapped))
    
        collectionView.register(TeaCell.self, forCellWithReuseIdentifier: "cellid")

    }

    // MARK: Public methods

    func addTea(tea: Tea) {
        teaCollection.add(tea)
        collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teaCollection.all.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! TeaCell
        cell.contentView.layer.cornerRadius = 30
        cell.teaNameLabel.text = teaCollection.all[indexPath.item].name
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tea = teaCollection.all[indexPath.item]
        let timerViewController = TimerViewController(teaName: tea.name, brewTime: tea.brewTime)
        timerViewController.title = tea.name
        navigationController?.pushViewController(timerViewController, animated: true)
    }

    // MARK: Target action methods

    @objc private func addTeaButtonTapped() {
        let addTeaViewController = AddTeaViewController()
        addTeaViewController.onNewTeaAdded = addTea
        let addTeaNavigationController = UINavigationController(rootViewController: addTeaViewController)
        self.navigationController?.present(addTeaNavigationController, animated: true, completion: nil)

    }
}

