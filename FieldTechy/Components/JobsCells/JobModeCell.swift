//
//  JobModeCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 28/08/26.
//

import UIKit

class JobModeCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var onSiteBtn: UIButton!
    @IBOutlet weak var remoteBtn: UIButton!
    
    var defaultSelectedTag: Int = 0
    var refreshCell: (() -> ())?
    
    private var jobModeButtons: [UIButton] {
        [onSiteBtn, remoteBtn]
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        jobModeButtons.forEach {
            $0.layer.cornerRadius = $0.bounds.height / 2
        }
        
        remoteBtn.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        remoteBtn.layer.borderWidth = 1
    }
    
    private func configure(_ buttons: [UIButton], isSelected: [UIButton:Bool]){
        for button in buttons{
            guard let isSelected = isSelected[button] else { return }
            button.isSelected = isSelected
            button.backgroundColor = isSelected ? AppTheme.primaryButtonTextColor : .clear
            button.setTitleColor(isSelected ? AppTheme.primaryButtonBGColor: AppTheme.primaryTextColor, for: .normal)
            button.layer.borderWidth = !isSelected ? 1 : 0
            button.layer.borderColor = !isSelected ? AppTheme.borderColorOfViews.cgColor : UIColor.clear.cgColor
        }
        refreshCell?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func onTapModeBtn(_ sender: UIButton) {
        if sender.tag == 0 {
            onSiteBtn.isSelected = true
            remoteBtn.isSelected = false
        } else {
            onSiteBtn.isSelected = false
            remoteBtn.isSelected = true
        }
        configure(jobModeButtons, isSelected: [onSiteBtn: onSiteBtn.isSelected, remoteBtn: remoteBtn.isSelected])
    }
}
