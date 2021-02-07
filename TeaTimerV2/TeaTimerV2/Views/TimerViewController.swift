import UIKit

class TimerViewController: UIViewController {

    // MARK: Properties
    
    private let teaName: String
    private let brewTimeInSeconds: Int
    private let timerLabel = UILabel()
    private let startButton = UIButton()
    private var timer = Timer()
    private var timeRemaining: Int

    // MARK: Initializers

    init(teaName: String, brewTimeInSeconds: Int) {
        self.teaName = teaName
        self.brewTimeInSeconds = brewTimeInSeconds
        self.timeRemaining = brewTimeInSeconds
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ViewController life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(brewTimeInSeconds)
        setupViews()
    }

    // MARK: Private methods

    private func setupViews() {
        view.addSubview(timerLabel)
        view.addSubview(startButton)

        // Timer label
        timerLabel.text = String(brewTimeInSeconds)
        timerLabel.backgroundColor = .systemTeal
        timerLabel.textColor = .white
        timerLabel.font = timerLabel.font.withSize(100)
        timerLabel.textAlignment = .center
        timerLabel.translatesAutoresizingMaskIntoConstraints = false

        // Start button
        startButton.setTitle("START", for: .normal)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.backgroundColor = .systemOrange
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)

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

    @objc func startButtonTapped() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1, repeats: true) { timer in
            if self.timeRemaining == 0 {
                timer.invalidate()
            } else {
                self.timeRemaining -= 1
                self.timerLabel.text = String(self.timeRemaining)
            }
        }
    }
}
