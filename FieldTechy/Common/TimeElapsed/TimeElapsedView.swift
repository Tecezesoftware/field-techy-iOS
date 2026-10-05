//
//  TimeElapsedView.swift
//  FieldTechy
//
//  Created by Kowsalya on 01/10/26.
//

import UIKit

class TimeElapsedView: UIView {

    // MARK: - IBOutlets

    @IBOutlet weak var elapsedTimeLabel: UILabel!
    @IBOutlet weak var checkOutButton: UIButton!
    @IBOutlet weak var additionalHoursButton: UIButton!


    // MARK: - Timer Properties

    private var timer: Timer?
    private var startDate: Date?

    /// Default working duration = 8 hours
    private let targetDuration: TimeInterval = 8 * 60 * 60


    // MARK: - Circular Progress Properties

    private let tickCount = 60
    private var tickLayers: [CAShapeLayer] = []
    private var ringCreated = false

    // MARK: - Button Actions

    /// Called when user taps Check Out.
    var onCheckOut: (() -> Void)?

    /// Called when user taps Request Additional Hours.
    var onRequestAdditionalHours: (() -> Void)?


    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setupProgressRing()
    }

    deinit {
        timer?.invalidate()
    }


    // MARK: - Setup

    private func setupUI() {

        setupButtons()
        elapsedTimeLabel.text = "00:00:00"
        elapsedTimeLabel.textAlignment = .center
        elapsedTimeLabel.font = UIFont.systemFont(
            ofSize: 44,
            weight: .bold
        )
    }


    private func setupButtons() {

        // Check Out Button

        checkOutButton.layer.cornerRadius = 15
        checkOutButton.clipsToBounds = true


        // Additional Hours Button

        additionalHoursButton.layer.cornerRadius = 15
        additionalHoursButton.layer.borderWidth = 1
        additionalHoursButton.layer.borderColor =
            UIColor.systemGreen.cgColor

        additionalHoursButton.clipsToBounds = true
    }


    // MARK: - Progress Ring

    private func setupProgressRing() {

        guard !ringCreated else {
            return
        }

        ringCreated = true

        /*
         The circular ring is positioned based on the size of
         the TimeElapsedView.

         If your XIB has a separate UIView for the circular
         timer area, it is better to use that UIView instead.
         */

        let center = CGPoint(
            x: bounds.midX,
            y: bounds.midY
        )

        let radius = min(
            bounds.width,
            bounds.height
        ) / 2 - 15


        for index in 0..<tickCount {

            let angle =
                CGFloat(index)
                / CGFloat(tickCount)
                * 2
                * .pi
                - (.pi / 2)

            let outerPoint = CGPoint(
                x: center.x + cos(angle) * radius,
                y: center.y + sin(angle) * radius
            )

            let innerPoint = CGPoint(
                x: center.x + cos(angle) * (radius - 8),
                y: center.y + sin(angle) * (radius - 8)
            )

            let path = UIBezierPath()

            path.move(to: innerPoint)
            path.addLine(to: outerPoint)

            let tickLayer = CAShapeLayer()
            tickLayer.path = path.cgPath
            tickLayer.lineWidth = 3
            tickLayer.lineCap = .butt
            tickLayer.strokeColor =
                UIColor.lightGray.cgColor
            layer.addSublayer(tickLayer)
            tickLayers.append(tickLayer)
        }
    }


    // MARK: - Start Timer

    /// Starts the elapsed timer.
    ///
    /// - Parameter startDate:
    ///   The actual check-in time received from the API.
    func startTimer(from startDate: Date = Date()) {

        self.startDate = startDate
        timer?.invalidate()
        updateTimer()
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
        RunLoop.main.add(
            timer!,
            forMode: .common
        )
    }

    // MARK: - Update Timer
    @objc private func updateTimer() {
        guard let startDate = startDate else {
            return
        }
        let elapsedTime =
            Date().timeIntervalSince(startDate)
        updateTimeLabel(elapsedTime)
        updateProgress(elapsedTime)
    }

    // MARK: - Update Time Label
    private func updateTimeLabel(_ elapsedTime: TimeInterval) {

        let totalSeconds =
            max(0, Int(elapsedTime))

        let hours =
            totalSeconds / 3600

        let minutes =
            (totalSeconds % 3600) / 60

        let seconds =
            totalSeconds % 60

        elapsedTimeLabel.text = String(
            format: "%02d:%02d:%02d",
            hours,
            minutes,
            seconds
        )
    }


    // MARK: - Update Circular Progress
    private func updateProgress(_ elapsedTime: TimeInterval) {
        guard !tickLayers.isEmpty else {
            return
        }
        
        let progress = min(max(elapsedTime / targetDuration, 0), 1)
        let activeTickCount = Int(progress * Double(tickCount))
        for (index, tickLayer) in tickLayers.enumerated() {
            if index < activeTickCount {
                tickLayer.strokeColor =
                    UIColor.systemGreen.cgColor

            } else {

                tickLayer.strokeColor =
                    UIColor.lightGray.cgColor
            }
        }
    }

    // MARK: - Stop Timer
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }


    // MARK: - Reset Timer
    func resetTimer() {
        stopTimer()
        startDate = nil
        elapsedTimeLabel.text = "00:00:00"
        updateProgress(0)
    }


    // MARK: - Check Out
    @IBAction func checkOutTapped(_ sender: UIButton){
        stopTimer()
        onCheckOut?()
    }

    // MARK: - Additional Hours
    @IBAction func additionalHoursTapped(_ sender: UIButton) {
        onRequestAdditionalHours?()
    }
}

extension UIView {

    static func loadFromXIB<T: UIView>() -> T {
        let nibName = String(describing: T.self)

        return Bundle.main.loadNibNamed(
            nibName,
            owner: nil,
            options: nil
        )!.first as! T
    }
}
