import UIKit

class AddTeaViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: Properties
    
    private var nameTextField = TextField()
    private var brewTimeTextField = TextField()
    private let brewTimePicker = UIPickerView()

    var onNewTeaAdded: ((Tea) -> Void)?

    // MARK: ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Tea"
        view.backgroundColor = .white

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))

        setupViews()
    }

    // MARK: Private methods
    
    private func setupViews() {
        view.addSubview(nameTextField)
        view.addSubview(brewTimeTextField)

        // Name textfield
        nameTextField.placeholder = "name"
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.cornerRadius = 10
        nameTextField.layer.borderColor = UIColor.systemGray.cgColor
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.delegate = self

        // Brew time textfield
        brewTimeTextField.placeholder = "brew time"
        brewTimeTextField.layer.borderWidth = 1
        brewTimeTextField.layer.cornerRadius = 10
        brewTimeTextField.layer.borderColor = UIColor.systemGray.cgColor
        brewTimeTextField.translatesAutoresizingMaskIntoConstraints = false
        brewTimeTextField.delegate = self
        brewTimeTextField.inputView = brewTimePicker

        // Brew time Picker
        brewTimePicker.dataSource = self
        brewTimePicker.delegate = self

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

    @objc private func saveButtonTapped() {

        guard let name = nameTextField.text,
              let brewTimeText = brewTimeTextField.text,
              let brewTime = Int(brewTimeText)
        else {
            return
        }

        let tea = Tea(name: name, brewTimeInMinutes: brewTime)
        self.onNewTeaAdded?(tea)
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: UITextfieldDelegate methods

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            brewTimeTextField.becomeFirstResponder()
        } else {
            saveButtonTapped()
        }
        return true
    }

    // MARK: UIPickerViewDelegate and UIPickerViewDataSource methods

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return 10
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return String(row + 1) + " min"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        brewTimeTextField.text = String(row + 1) 
    }
    
}

