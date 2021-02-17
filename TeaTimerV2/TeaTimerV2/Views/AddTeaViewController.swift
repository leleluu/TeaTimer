import UIKit

class AddTeaViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIColorPickerViewControllerDelegate {

    // MARK: Properties
    
    private var nameTextField = TextField()
    private var brewTimeTextField = TextField()
    private let brewTimePicker = UIPickerView()
    private let errorLabel = UILabel()
    private let colorPickerButton = UIButton()
    private var selectedColor = UIColor()

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
        view.addSubview(errorLabel)
        view.addSubview(colorPickerButton)

        // Name textfield
        nameTextField.placeholder = "name"
        nameTextField.becomeFirstResponder()
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

        // Error Label
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.numberOfLines = 0
        errorLabel.text = "Your tea could not be saved ☹️. Please check the name and time fields are not empty."
        errorLabel.textColor = .systemRed
        errorLabel.isHidden = true

        // Color picker button
        colorPickerButton.translatesAutoresizingMaskIntoConstraints = false
        colorPickerButton.setTitle("Pick a colour for your tea!", for: .normal)
        colorPickerButton.layer.cornerRadius = 15
        colorPickerButton.backgroundColor = .systemYellow
        colorPickerButton.addTarget(self, action: #selector(colorPickerButtonTapped), for: .touchUpInside)

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
            errorLabel.heightAnchor.constraint(equalToConstant: 50),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            errorLabel.topAnchor.constraint(equalTo: brewTimeTextField.bottomAnchor, constant: 32),
            colorPickerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            colorPickerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            colorPickerButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 32),
        ])
    }

    // MARK: Target action methods

    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc private func saveButtonTapped() {

        if let name = nameTextField.text,
           nameTextField.text?.isEmpty == false,
           let brewTimeText = brewTimeTextField.text,
           let brewTime = Int(brewTimeText) {
            let tea = Tea(name: name, brewTimeInMinutes: brewTime, backgroundColor: Color.init(uiColor: selectedColor))
                self.onNewTeaAdded?(tea)
                self.dismiss(animated: true, completion: nil)
            errorLabel.isHidden = true

        } else {
            errorLabel.isHidden = false
        }
    }

    @objc private func colorPickerButtonTapped() {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.supportsAlpha = false
        present(picker, animated: true, completion: nil)
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

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        errorLabel.isHidden = true

        if textField == brewTimeTextField {
            brewTimeTextField.text = String(brewTimePicker.selectedRow(inComponent: 0) + 1)
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

    // MARK: UIColorPickerViewControllerDelegate methods

    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        self.colorPickerButton.backgroundColor = color
        self.selectedColor = color
    }
}

