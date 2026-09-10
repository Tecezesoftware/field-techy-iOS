//
//  TaskInfomationView.swift
//  FieldTechy
//
//  Created by Kowsalya on 08/09/26.
//

import UIKit

class TaskInfomationView: UIView {
    
    @IBOutlet weak var skillLevelLabel: UILabel!
    @IBOutlet weak var workStartDateLabel: UILabel!
    @IBOutlet weak var workEndDateLabel: UILabel!
    
    @IBOutlet weak var jobSkillView: UIView!
    @IBOutlet weak var jobSkillStackView: UIStackView!
    @IBOutlet weak var skillview: UIView!
    @IBOutlet weak var skillLabel: UILabel!
    
    @IBOutlet weak var SPOCHeaderView: UIView!
    @IBOutlet weak var SPOCHeaderLabel: UILabel!
    @IBOutlet weak var SPOCStackView: UIStackView!
    @IBOutlet weak var SPOCNameLabel: UILabel!
    @IBOutlet weak var SPOCEmailLabel: UILabel!
    @IBOutlet weak var SPOCPhLabel: UILabel!
    
    @IBOutlet weak var SMEHeaderView: UIView!
    @IBOutlet weak var SMEHeaderLabel: UILabel!
    @IBOutlet weak var SMEStackView: UIStackView!
    @IBOutlet weak var SMENameLabel: UILabel!
    @IBOutlet weak var SMEEmailLabel: UILabel!
    @IBOutlet weak var SMEPhLabel: UILabel!
    
    @IBOutlet weak var toolRequiredView: UIView!
    @IBOutlet weak var toolsOuterView: UIView!
    @IBOutlet weak var toolStackView: UIStackView!
    @IBOutlet weak var toolView: UIView!
    @IBOutlet weak var toolNameLabel: UILabel!
    
    @IBOutlet weak var JDStackView: UIStackView!
    @IBOutlet weak var JDContentLabel: UILabel!
    
    @IBOutlet weak var attachmentHeaderView: UIView!
    @IBOutlet weak var attachmentHeaderCountLabel: UILabel!
    @IBOutlet weak var attachmentStackView: UIStackView!
    @IBOutlet weak var attachmentView: UIView!
    @IBOutlet weak var fileLogoImageView: UIImageView!
    @IBOutlet weak var filenameLabel: UILabel!
    @IBOutlet weak var fileSizeLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        attachmentView.layer.borderColor = AppTheme.brandPrimaryTint.cgColor
        attachmentView.layer.borderWidth = 1.5
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureUI() {
        
    }
    
    @IBAction func approveEngineer(_ sender: Any) {
        
    }
    
    @IBAction func rejectEngineer(_ sender: Any) {
        
    }
}

extension TaskInfomationView {

    static func loadFromXIB() -> TaskInfomationView? {
        let nib = UINib(
            nibName: "TaskInfomationView",
            bundle: nil
        )

        return nib.instantiate(
            withOwner: nil,
            options: nil
        ).first as? TaskInfomationView
    }
}
