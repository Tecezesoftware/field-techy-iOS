//
//  JobsTextFieldWithDDCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 28/08/26.
//

import UIKit

class JobsTextFieldWithDDCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fieldsOuterView: UIView!
    @IBOutlet weak var dropDownField: UITextField!
    @IBOutlet weak var dropDownBtn: UIButton!
    
    var isExpaned: ((Bool) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fieldsOuterView.layer.cornerRadius = 5
        fieldsOuterView.layer.borderWidth = 1.5
        fieldsOuterView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        fieldsOuterView.layer.masksToBounds = true
    }
    
    func configureUI(isRequired:Bool, title:String, placeHolder:String){
        if isRequired == true {
            let attr = NSMutableAttributedString(string: title,
                                                 attributes: [.foregroundColor: AppTheme.primaryTextColor, .font: AppFonts.Regular(size: 12.0)])
            
            attr.append(NSAttributedString(
                string: " *",
                attributes: [.foregroundColor: UIColor.red, .font: AppFonts.Regular(size: 12.0)]
            ))
            titleLabel.attributedText = attr
        } else {
            let attr = NSMutableAttributedString(string: title,
                                                 attributes: [.foregroundColor: AppTheme.primaryTextColor, .font: AppFonts.Regular(size: 12.0)])
            titleLabel.attributedText = attr
            
        }
        
        if dropDownField.text?.isEmpty == true {
            dropDownField.placeholder = placeHolder
        }
    }
    
    func configureUIForFilter(title:String){
        dropDownBtn.setImage(UIImage(named: "GreenDropDown"), for: .normal)
        let attr = NSMutableAttributedString(string: title,
                                             attributes: [.foregroundColor: AppTheme.primaryTextColor, .font: AppFonts.SemiBold(size: 13.0)])
        titleLabel.attributedText = attr
        dropDownField.placeholder = "All"
    }
    
    @IBAction func showDropDown(_ sender: UIButton) {
        sender.isSelected.toggle()
        self.isExpaned?(sender.isSelected)
    }
}
