import UIKit

class TimerViewController: UIViewController {

    // MARK: Properties
    
    private let teaName: String
    private let brewTime: Int
    var timerLabel = UILabel()
    private var startButton = UIButton()

    // MARK: Initializers

    init(teaName: String, brewTime: Int) {
        self.teaName = teaName
        self.brewTime = brewTime
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ViewController life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(brewTime)
        setupViews()
    }

    // MARK: Private methods

    private func setupViews() {
        view.addSubview(timerLabel)
        view.addSubview(startButton)

        // Timer label
        timerLabel.text = String(brewTime) // okay as string for now
        timerLabel.backgroundColor = .systemTeal
        timerLabel.textColor = .white
        timerLabel.font = timerLabel.font.withSize(100)
        timerLabel.textAlignment = .center
        timerLabel.translatesAutoresizingMaskIntoConstraints = false

        // Start button
        startButton.setTitle("START", for: .normal)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.backgroundColor = .systemOrange

        // Constraints
        NSLayoutConstraint.activate([
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            startButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 32)
        ])
    }
}
