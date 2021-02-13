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

        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(longpressHappened))
        longPressRecogniser.minimumPressDuration = 1
        collectionView.addGestureRecognizer(longPressRecogniser)
    }

    // MARK: Public methods

    func addTea(tea: Tea) {
        teaCollection.add(tea)
        collectionView.reloadData()
    }

    func removeTea(at index: Int) {
        teaCollection.remove(at: index)
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
        let timerViewController = TimerViewController(teaName: tea.name, brewTimeInSeconds: tea.brewTimeInSeconds)
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

    @objc func longpressHappened(sender: UILongPressGestureRecognizer) {
        let position = sender.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: position) {
            let index = indexPath.row

            let alert = UIAlertController(title: "Do you want to delete this tea?", message: nil, preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { alertAction in
                self.removeTea(at: index)
                })
            )

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}

