//
//  EngineerActivityInOutView.swift
//  FieldTechy
//
//  Created by Kowsalya on 01/10/26.
//

import UIKit

class EngineerActivityInOutView: UIView {
    
    @IBOutlet weak var trackingInStackView: UIView!
    @IBOutlet weak var timesheetInStackView: UIStackView!
    
    @IBOutlet weak var checkInView: UIView!
    @IBOutlet weak var checkInViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var checkOutView: UIView!
    @IBOutlet weak var timeElapsedContainerView: UIView!
    @IBOutlet weak var trackingStackView: UIStackView!
    @IBOutlet weak var workModeBGView: UIView!
    @IBOutlet weak var workModeLabel: UILabel!
    @IBOutlet weak var checkInTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var expectedFinishLabel: UILabel!
    
    @IBOutlet weak var taskDataCheckListView: UIView!
    @IBOutlet weak var SPOCHeaderView: UIView!
    @IBOutlet weak var SPOCHeaderLabel: UILabel!
    
    @IBOutlet weak var SPOCDataStackView: UIStackView!
    @IBOutlet weak var SPOCNameLabel: UILabel!
    @IBOutlet weak var SPOCEmailLabel: UILabel!
    @IBOutlet weak var SPOCPhNumLabel: UILabel!
    
    @IBOutlet weak var SMEHeaderView: UIView!
    @IBOutlet weak var SMEHeaderLabel: UILabel!
    
    @IBOutlet weak var SMEDataStackView: UIStackView!
    @IBOutlet weak var SMENameLabel: UILabel!
    @IBOutlet weak var SMEEmailLabel: UILabel!
    @IBOutlet weak var SMEPhNumLabel: UILabel!
    
    @IBOutlet weak var checklistHeaderView: UIView!
    @IBOutlet weak var checklistHeaderLabel: UILabel!
    @IBOutlet weak var checklistOuterStackView: UIStackView!
    
    @IBOutlet weak var checklistInnerStackView: UIStackView!
    @IBOutlet weak var checklistButton: UIButton!
    @IBOutlet weak var checklistDescLabel: UILabel!
    
    @IBOutlet weak var timesheetStackView: UIStackView!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var AllTimeLabel: UILabel!
    @IBOutlet weak var timesheetHeaderLabel: UILabel!
    @IBOutlet weak var timesheetContainerStackView: UIStackView!
    @IBOutlet weak var dailyTaskOuterView: UIView!
    @IBOutlet weak var dailyTaskTitleLabel: UILabel!
    @IBOutlet weak var dailyTaskDateLabel: UILabel!
    @IBOutlet weak var dailyTaskDescLabel: UILabel!
    @IBOutlet weak var dailyStatusOuterView: UIView!
    @IBOutlet weak var dailyStatusLabel: UILabel!
    
    @IBOutlet weak var weeklyTaskOuterView: UIView!
    @IBOutlet weak var WeeklyTaskDateLabel: UILabel!
    @IBOutlet weak var weeklyStatusOuterView: UIView!
    @IBOutlet weak var weeklyStatusLabel: UILabel!
    @IBOutlet weak var weeklySubmittedHrsLabel: UILabel!
    @IBOutlet weak var weeklyApproveHrsLabel: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
    
    private var timeElapsedView: TimeElapsedView!
    var jobMode: jobTypes?
    let dateFormatter = DateFormatter()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.checkInView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        self.checkInView.layer.borderWidth = 1
    }
    
    func configureUI(jobMode: jobTypes){
        setupTimeElapsedView()
        self.checkOutView.isHidden = true
        self.checkInView.isHidden = false
        
        if jobMode == .dispatch{
            //MARK: - Check in view
            self.trackingInStackView.isHidden = true
            self.timesheetInStackView.isHidden = true
            self.checkInViewHeight.constant = 190
            
            //MARK: - Check out view
            self.taskDataCheckListView.isHidden = false
            self.timesheetStackView.isHidden = true
            self.submitButton.setTitle("Mark as completed", for: .normal)
            
        }else if jobMode == .fulltime{
            //MARK: - Check in view
            self.trackingInStackView.isHidden = false
            self.timesheetInStackView.isHidden = false
            self.checkInViewHeight.constant = 590
            
            //MARK: - Check out view
            self.taskDataCheckListView.isHidden = true
            self.timesheetStackView.isHidden = false
            self.submitButton.setTitle("Submit all", for: .normal)
            
        }else if jobMode == .scheduled{
            //MARK: - Check in view
            self.trackingInStackView.isHidden = true
            self.timesheetInStackView.isHidden = false
            self.checkInViewHeight.constant = 407
            
            //MARK: - Check out view
            self.taskDataCheckListView.isHidden = true
            self.timesheetStackView.isHidden = false
            self.submitButton.setTitle("Submit all", for: .normal)
        }
    }

    private func setupTimeElapsedView() {

        timeElapsedView = TimeElapsedView.loadFromXIB()
        timeElapsedView.configure()
        timeElapsedContainerView.addSubview(timeElapsedView)

        timeElapsedView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            timeElapsedView.topAnchor.constraint(
                equalTo: timeElapsedContainerView.topAnchor
            ),
            timeElapsedView.leadingAnchor.constraint(
                equalTo: timeElapsedContainerView.leadingAnchor
            ),
            timeElapsedView.trailingAnchor.constraint(
                equalTo: timeElapsedContainerView.trailingAnchor
            ),
            timeElapsedView.bottomAnchor.constraint(
                equalTo: timeElapsedContainerView.bottomAnchor
            )
        ])
        timeElapsedView.setupProgressRing()
    }
    
    @IBAction func onTapCheckIn(_ sender: Any) {
        self.checkOutView.isHidden = false
        self.checkInView.isHidden = true
        self.checkInViewHeight.constant = 0
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current

        if let checkInDate = dateFormatter.date(from: "2026-10-12 10:00:00") {
            timeElapsedView.startTimer(from: checkInDate)
        }
    }
    
    @IBAction func submitActions(_ sender: Any) {
    
    }
}
