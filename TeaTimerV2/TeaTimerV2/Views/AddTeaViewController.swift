import UIKit

class AddTeaViewController: UIViewController {

    // MARK: Properties
    
    private var nameTextField = UITextField()
    private var brewTimeTextField = UITextField()

    // MARK: ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Tea"
        view.backgroundColor = .white

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))

        setupViews()
    }

    // MARK: Private methods
    
    private func setupViews() {
        view.addSubview(nameTextField)
        view.addSubview(brewTimeTextField)

        // Name textfield
        nameTextField.placeholder = "name"
//        nameTextField.borderStyle = .line
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.cornerRadius = 10
        nameTextField.layer.borderColor = UIColor.systemGray.cgColor
        nameTextField.translatesAutoresizingMaskIntoConstraints = false

        // Brew time textfield
        brewTimeTextField.placeholder = "brew time"
        brewTimeTextField.layer.borderWidth = 1
        brewTimeTextField.layer.cornerRadius = 10
        brewTimeTextField.layer.borderColor = UIColor.systemGray.cgColor
        brewTimeTextField.translatesAutoresizingMaskIntoConstraints = false

        // Constraints
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: 35),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            nameTextField.bottomAnchor.constraint(equalTo: brewTimeTextField.topAnchor, constant: -16),
            brewTimeTextField.heightAnchor.constraint(equalToConstant: 35),
            brewTimeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            brewTimeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
    }

    // MARK: Target action methods

    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

}

