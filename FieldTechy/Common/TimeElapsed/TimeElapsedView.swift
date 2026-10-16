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
    @IBOutlet weak var timerContainerView: UIView!
    
    
    // MARK: - Timer Properties
    
    private var timer: Timer?
    private var startDate: Date?
    
    /// Default working duration = 8 hours
    private let targetDuration: TimeInterval = 8 * 60 * 60
    
    
    // MARK: - Circular Progress Properties
    
    private let tickCount = 110
    private var tickLayers: [CAShapeLayer] = []
    private var ringCreated = false
    private var lastRingSize: CGSize = .zero
    
    // MARK: - Button Actions
    
    /// Called when user taps Check Out.
    var onCheckOut: (() -> Void)?
    
    /// Called when user taps Request Additional Hours.
    var onRequestAdditionalHours: (() -> Void)?
    
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
    
    func setupProgressRing() {
        let size = timerContainerView.bounds.size
        
        // Wait until Auto Layout provides the actual size.
        guard size.width > 0, size.height > 0 else {
            return
        }
        
        // Rebuild only when the container size changes.
        guard size != lastRingSize else {
            return
        }
        
        lastRingSize = size
        
        // Remove previously created ticks.
        tickLayers.forEach { $0.removeFromSuperlayer() }
        tickLayers.removeAll()
        
        let center = CGPoint(
            x: size.width / 2,
            y: size.height / 2
        )
        
        let radius = min(size.width, size.height) / 2 - 8
        
        for index in 0..<tickCount {
            
            let angle =
            CGFloat(index) / CGFloat(tickCount)
            * 2 * .pi - (.pi / 2)
            
            let outerPoint = CGPoint(
                x: center.x + cos(angle) * radius,
                y: center.y + sin(angle) * radius
            )
            
            let innerPoint = CGPoint(
                x: center.x + cos(angle) * (radius - 7),
                y: center.y + sin(angle) * (radius - 7)
            )
            
            let path = UIBezierPath()
            path.move(to: innerPoint)
            path.addLine(to: outerPoint)
            
            let tickLayer = CAShapeLayer()
            tickLayer.path = path.cgPath
            tickLayer.lineWidth = 2
            tickLayer.strokeColor = AppTheme.neutralLight300.cgColor
            
            timerContainerView.layer.addSublayer(tickLayer)
            tickLayers.append(tickLayer)
        }
        
        // Refresh the ring using the current elapsed time.
        if let startDate = startDate {
            updateProgress(Date().timeIntervalSince(startDate))
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
                tickLayer.strokeColor = AppTheme.primaryButtonBGColor.cgColor //borderColorOfViews
            } else {
                tickLayer.strokeColor = AppTheme.neutralLight300.cgColor
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
