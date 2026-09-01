//
//  JobTypeCellTableViewCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 28/08/26.
//

import UIKit

class JobTypeCell: UITableViewCell {
    
    @IBOutlet weak var dispatchButton: UIButton!
    @IBOutlet weak var fullTimeButton: UIButton!
    @IBOutlet weak var scheduledButton: UIButton!
    
    var respectiveBtnTag: ((Int) -> Void)?
    var defaultSelectedTag: Int = 1
    
    private var jobTypeButtons: [UIButton] {
        [dispatchButton, fullTimeButton, scheduledButton]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        jobTypeButtons.forEach {
            $0.layer.cornerRadius = $0.bounds.height / 2
        }
    }
    
    func configureUI() {
        jobTypeButtons.forEach { button in
            configure(
                button,
                isSelected: button.tag == defaultSelectedTag
            )
        }
    }
    
    private func configure(_ button: UIButton, isSelected: Bool) {
        if isSelected {
            configureSelectedButton(button)
        } else {
            configureUnselectedButton(button)
        }
    }
    
    private func configureSelectedButton(_ button: UIButton) {
        button.layer.borderWidth = 0
        button.setTitleColor(AppTheme.primaryButtonTextColor, for: .normal)
        button.backgroundColor = AppTheme.brandPrimaryTint
    }
    
    private func configureUnselectedButton(_ button: UIButton) {
        button.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(AppTheme.primaryTextColor, for: .normal)
        button.backgroundColor = .clear
    }
    
    @IBAction private func switchJobType(_ sender: UIButton) {
        defaultSelectedTag = sender.tag
        configureUI()
        respectiveBtnTag?(sender.tag)
    }
}
