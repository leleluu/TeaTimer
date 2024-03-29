import UIKit
import AVFoundation
import UserNotifications

class TimerViewController: UIViewController {

    // MARK: Properties
    
    private let teaName: String
    private let brewTimeInSeconds: Int
    private let timerLabel = UILabel()
    private let startPauseTimerButton = UIButton()
    private let resetTimerButton = UIButton()

    private var timer = Timer()
    private var timeRemaining: Int
    private var timerIsRunning = false

    private var timeAppEnteredBackground: Date?

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
        view.backgroundColor = .systemYellow
        setupViews()

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appEnteredBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)

        notificationCenter.addObserver(self, selector: #selector(appEnteredForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }


    // MARK: Private methods

    private func setupViews() {
        view.addSubview(timerLabel)
        view.addSubview(startPauseTimerButton)
        view.addSubview(resetTimerButton)

        // Navigation bar
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))

        navigationItem.leftBarButtonItem = cancelButton

        // Timer label
        updateTimerLabel(with: timeRemaining)
        timerLabel.textColor = .white
        timerLabel.font = timerLabel.font.withSize(100)
        timerLabel.textAlignment = .center
        timerLabel.adjustsFontSizeToFitWidth = true
        timerLabel.translatesAutoresizingMaskIntoConstraints = false

        // Start button
        startPauseTimerButton.setTitle("START", for: .normal)
        startPauseTimerButton.translatesAutoresizingMaskIntoConstraints = false
        startPauseTimerButton.backgroundColor = .systemIndigo
        startPauseTimerButton.layer.cornerRadius = 15
        startPauseTimerButton.addTarget(self, action: #selector(startPauseTimerButtonTapped), for: .touchUpInside)

        // Reset button
        resetTimerButton.setTitle("RESET", for: .normal)
        resetTimerButton.translatesAutoresizingMaskIntoConstraints = false
        resetTimerButton.backgroundColor = .systemGray
        resetTimerButton.layer.cornerRadius = 15
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

    private func startTimer() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1, repeats: true) { timer in
            if self.timeRemaining == 0 {
                timer.invalidate()
                self.timerLabel.text = "Tea is ready!"
                self.playSound()
            } else {
                self.timeRemaining -= 1
                self.updateTimerLabel(with: self.timeRemaining)
            }
        }
        startPauseTimerButton.setTitle("PAUSE", for: .normal)
        startPauseTimerButton.backgroundColor = .systemTeal
        timerIsRunning = true
    }

    private func pauseTimer() {
        timer.invalidate()
        timerIsRunning = false
        startPauseTimerButton.setTitle("START", for: .normal)
        startPauseTimerButton.backgroundColor = .systemIndigo
    }

    private func playSound() {
        let systemSoundID: SystemSoundID = 1016
        AudioServicesPlaySystemSound(systemSoundID)
    }

    private func resetTimer() {
        pauseTimer()
        timeRemaining = brewTimeInSeconds
        updateTimerLabel(with: timeRemaining)
    }

    @objc func startPauseTimerButtonTapped() {
        if timerIsRunning {
            pauseTimer()
        } else {
            startTimer()
        }
    }

    @objc func resetTimerButtonTapped() {
        resetTimer()
    }

    @objc func appEnteredBackground() {
        timeAppEnteredBackground = Date()
        timer.invalidate()

        guard timerIsRunning else {
            return
        }

        let content = UNMutableNotificationContent()
        content.title = "Tea is ready!"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(self.timeRemaining), repeats: false)

        let request = UNNotificationRequest(identifier: "Timer", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    @objc func appEnteredForeground() {
        guard timerIsRunning else {
            return
        }
        let timeElapsed = Int(Date().timeIntervalSince(timeAppEnteredBackground!)) + 1
        timeRemaining -= timeElapsed

        if timeRemaining == 0 {
            timer.invalidate()
            timerLabel.text = "Tea is ready!"
            playSound()
        } else if timeRemaining < 0 {
            resetTimer()
        } else {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Timer"])
            updateTimerLabel(with: timeRemaining)
            startTimer()
        }
    }

    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
