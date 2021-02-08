import UIKit

class TimerViewController: UIViewController {

    // MARK: Properties
    
    private let teaName: String
    private let brewTimeInSeconds: Int
    private let timerLabel = UILabel()
    private let startTimer = UIButton()
    private let resetTimer = UIButton()
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
        view.addSubview(startTimer)
        view.addSubview(resetTimer)

        // Timer label
        updateTimerLabel(with: timeRemaining)
        timerLabel.backgroundColor = .systemTeal
        timerLabel.textColor = .white
        timerLabel.font = timerLabel.font.withSize(100)
        timerLabel.textAlignment = .center
        timerLabel.translatesAutoresizingMaskIntoConstraints = false

        // Start button
        startTimer.setTitle("START", for: .normal)
        startTimer.translatesAutoresizingMaskIntoConstraints = false
        startTimer.backgroundColor = .systemOrange
        startTimer.addTarget(self, action: #selector(startTimerTapped), for: .touchUpInside)

        // Reset button
        resetTimer.setTitle("RESET", for: .normal)
        resetTimer.translatesAutoresizingMaskIntoConstraints = false
        resetTimer.backgroundColor = .systemIndigo
        resetTimer.addTarget(self, action: #selector(resetTimerTapped), for: .touchUpInside)


        // Constraints
        NSLayoutConstraint.activate([
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startTimer.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 16),
            startTimer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            startTimer.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 32),
            resetTimer.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 32),
            resetTimer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            resetTimer.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -16)
        ])
    }

    func updateTimerLabel(with timeRemaining: Int) {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        self.timerLabel.text = String(format: "%02i:%02i", minutes, seconds)

    }

    @objc func startTimerTapped() {
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

    @objc func resetTimerTapped() {
        timer.invalidate()
        timeRemaining = brewTimeInSeconds
        updateTimerLabel(with: timeRemaining)
    }
}
