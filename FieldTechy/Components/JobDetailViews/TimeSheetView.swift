//
//  TimeSheetView.swift
//  FieldTechy
//
//  Created by Kowsalya on 10/09/26.
//

import UIKit

class TimeSheetView: UIView {

    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var allTimeLabel: UILabel!
    
    @IBOutlet weak var timesheetHeaderLabel: UILabel!
    
    @IBOutlet weak var timeSheetContainer: UIView!
    @IBOutlet weak var timeSheetContainerStackView: UIStackView!
    
    @IBOutlet weak var todaysSheetContainerView: UIView!
    @IBOutlet weak var todayTaskContentStackView: UIStackView!
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var todayTaskDateLabel: UILabel!
    @IBOutlet weak var todayTaskDesLabel: UILabel!
    
    @IBOutlet weak var allTimeSheetContainerView: UIView!
    @IBOutlet weak var allTimeTaskDateLabel: UILabel!
    @IBOutlet weak var allTimeStatusView: UIView!
    @IBOutlet weak var allTimeStatusLabel: UILabel!
    @IBOutlet weak var submittedHrsLabel: UILabel!
    @IBOutlet weak var approvedHrsLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        todaysSheetContainerView.layer.cornerRadius = 10
        todaysSheetContainerView.layer.borderWidth = 1
        todaysSheetContainerView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        
        allTimeSheetContainerView.layer.cornerRadius = 10
        allTimeSheetContainerView.layer.borderWidth = 1
        allTimeSheetContainerView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
    }
    
    @IBAction func onTapToggle(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            sender.setImage(UIImage(named: "SwitchOnIcon"), for: .normal)
            
            todayLabel.font = AppFonts.SemiBold(size: 12)
            todayLabel.textColor = AppTheme.primaryButtonBGColor
            todaysSheetContainerView.isHidden = false
            
            allTimeLabel.font = AppFonts.Medium(size: 12)
            allTimeLabel.textColor = AppTheme.primaryTextColor
            allTimeSheetContainerView.isHidden = true
        }else{
            sender.setImage(UIImage(named: "SwitchOffIcon"), for: .normal)
            
            todayLabel.font = AppFonts.Medium(size: 12)
            todayLabel.textColor = AppTheme.primaryTextColor
            todaysSheetContainerView.isHidden = true
            
            allTimeLabel.font = AppFonts.SemiBold(size: 12)
            allTimeLabel.textColor = AppTheme.primaryButtonBGColor
            allTimeSheetContainerView.isHidden = false
        }
        
    }
    
}

extension TimeSheetView {
    
    static func loadFromXIB() -> TimeSheetView? {
        let nib = UINib(
            nibName: "TimeSheetView",
            bundle: nil
        )

        return nib.instantiate(
            withOwner: nil,
            options: nil
        ).first as? TimeSheetView
    }
}
