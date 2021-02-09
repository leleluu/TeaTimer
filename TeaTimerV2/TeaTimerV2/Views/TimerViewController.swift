import UIKit

class TimerViewController: UIViewController {

    // MARK: Properties
    
    private let teaName: String
    private let brewTimeInSeconds: Int
    private let timerLabel = UILabel()
    private let startPauseTimerButton = UIButton()
    private let resetTimerButton = UIButton()

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
        setupViews()
    }

    // MARK: Private methods

    private func setupViews() {
        view.addSubview(timerLabel)
        view.addSubview(startPauseTimerButton)
        view.addSubview(resetTimerButton)

        // Timer label
        updateTimerLabel(with: timeRemaining)
        timerLabel.backgroundColor = .systemTeal
        timerLabel.textColor = .white
        timerLabel.font = timerLabel.font.withSize(100)
        timerLabel.textAlignment = .center
        timerLabel.translatesAutoresizingMaskIntoConstraints = false

        // Start button
        startPauseTimerButton.setTitle("START", for: .normal)
        startPauseTimerButton.translatesAutoresizingMaskIntoConstraints = false
        startPauseTimerButton.backgroundColor = .systemOrange
        startPauseTimerButton.addTarget(self, action: #selector(startPauseTimerButtonTapped), for: .touchUpInside)

        // Reset button
        resetTimerButton.setTitle("RESET", for: .normal)
        resetTimerButton.translatesAutoresizingMaskIntoConstraints = false
        resetTimerButton.backgroundColor = .systemIndigo
        resetTimerButton.addTarget(self, action: #selector(resetTimerButtonTapped), for: .touchUpInside)


        // Constraints
        NSLayoutConstraint.activate([
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startPauseTimerButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 16),
            startPauseTimerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            startPauseTimerButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 32),
            resetTimerButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 32),
            resetTimerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            resetTimerButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -16)
        ])
    }

    func updateTimerLabel(with timeRemaining: Int) {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        self.timerLabel.text = String(format: "%02i:%02i", minutes, seconds)

    }

    @objc func startPauseTimerButtonTapped() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1, repeats: true) { timer in
            if self.timeRemaining == 0 {
                timer.invalidate()
            } else {
                self.timeRemaining -= 1
                self.updateTimerLabel(with: self.timeRemaining)
            }
        }
    }

    @objc func resetTimerButtonTapped() {
        timer.invalidate()
        timeRemaining = brewTimeInSeconds
        updateTimerLabel(with: timeRemaining)
    }
}
