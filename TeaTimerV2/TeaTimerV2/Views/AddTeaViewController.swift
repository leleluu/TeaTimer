import UIKit

class AddTeaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Tea"

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
    }

    // MARK: Target action methods

    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

}

