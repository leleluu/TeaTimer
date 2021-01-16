import UIKit

class TeaCollectionViewController: UICollectionViewController {

    // TODO: Remove dummy data
    let earlGrey = Tea(name: "Earl Grey", brewTime: 1)
    let rooibos = Tea(name: "Rooibos", brewTime: 2)
    let jasmine = Tea(name: "Jasmine", brewTime: 3)

    var teaCollection = [Tea]()

    override func viewDidLoad() {
        super.viewDidLoad()
        teaCollection.append(earlGrey)
        teaCollection.append(rooibos)
        teaCollection.append(jasmine)

        collectionView.backgroundColor = .white
    
        collectionView.register(TeaCell.self, forCellWithReuseIdentifier: "cellid")

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
}

