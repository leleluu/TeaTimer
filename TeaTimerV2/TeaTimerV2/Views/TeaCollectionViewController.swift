import UIKit
import UserNotifications

class TeaCollectionViewController: UICollectionViewController {

    // MARK: Properties

    var teaCollection = TeaCollection()

    // MARK: ViewController life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        requestPermissionForNotifications()

        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        self.title = "Tea Collection"
    
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

    // MARK: Private methods

    private func addTeaButtonTapped() {
        let addTeaViewController = AddTeaViewController()
        addTeaViewController.onNewTeaAdded = addTea
        let addTeaNavigationController = UINavigationController(rootViewController: addTeaViewController)
        self.navigationController?.present(addTeaNavigationController, animated: true, completion: nil)

    }

    private func requestPermissionForNotifications() {

        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            // Completion handler is non optional but not required for this use case
            }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teaCollection.all.count + 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! TeaCell
        cell.contentView.layer.cornerRadius = 30

        if indexPath.row == teaCollection.all.count  {
            cell.teaNameLabel.text = "add a tea"
            cell.contentView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.5)
            cell.teaImageView.image = UIImage(named: "plus")

        } else {
            cell.teaNameLabel.text = teaCollection.all[indexPath.item].name
            cell.contentView.backgroundColor = teaCollection.all[indexPath.item].backgroundColor.uiColor
            cell.teaImageView.image = UIImage(named: "teacup")

        }

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == teaCollection.all.endIndex {
            addTeaButtonTapped()
        } else {
            let tea = teaCollection.all[indexPath.item]
            let timerViewController = TimerViewController(teaName: tea.name, brewTimeInSeconds: tea.brewTimeInSeconds)
            timerViewController.title = tea.name

            let navigationController = UINavigationController(rootViewController: timerViewController)
            self.present(navigationController, animated: true, completion: nil)
        }

    }

    // MARK: Target action methods

    @objc func longpressHappened(sender: UILongPressGestureRecognizer) {
        let position = sender.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: position) {
            let index = indexPath.row
            if indexPath.row == teaCollection.all.endIndex {
                return
            } else {
                let alert = UIAlertController(title: "Do you want to delete this tea?", message: nil, preferredStyle: .actionSheet)

                alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { alertAction in
                    self.removeTea(at: index)
                    })
                )
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

