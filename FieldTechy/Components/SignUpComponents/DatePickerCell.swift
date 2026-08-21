//
//  DatePickerCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 18/08/26.
//

import UIKit

class DatePickerCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var DateField: UITextField!
    
    var engineerFormItem:EngineerFormItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureUI() {
        titleLabel.attributedText = requiredFieldTitleStyle(title: engineerFormItem?.title ?? "")
        
        DateField.placeholder = engineerFormItem?.placeholder ?? ""
        DateField.layer.cornerRadius = 10
        DateField.layer.borderWidth = 1.5
        DateField.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        DateField.layer.masksToBounds = true
    }
    
    func requiredFieldTitleStyle(title:String) -> NSMutableAttributedString{
        let attr = NSMutableAttributedString(string: title,
                                             attributes: [.foregroundColor: AppTheme.primaryTextColor, .font: AppFonts.Regular(size: 12.0)])
        
        attr.append(NSAttributedString(
            string: " *",
            attributes: [.foregroundColor: UIColor.red, .font: AppFonts.Regular(size: 12.0)]
        ))
        return attr
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
