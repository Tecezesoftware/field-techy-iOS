//
//  JobsTextFieldCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 28/08/26.
//

import UIKit

class JobsTextFieldCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textFieldView: UITextField!
    @IBOutlet weak var textFieldHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textFieldView.delegate = self
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
        textFieldView.layer.cornerRadius = 5
        textFieldView.layer.borderWidth = 1.5
        textFieldView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        textFieldView.layer.masksToBounds = true
        if textFieldView.text?.isEmpty == true {
            textFieldView.placeholder = placeHolder
        }
    }
}

extension JobsTextFieldCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    print("✅ Did begin editing, content: \(textField.text ?? "")")
    }
}
