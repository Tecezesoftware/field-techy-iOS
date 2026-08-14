//
//  TextFieldCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 07/08/26.
//

import UIKit

class TextFieldCell: UITableViewCell {

    //MARK: - Outlet Properties
    @IBOutlet weak var fieldTitleLabel: UILabel!
    @IBOutlet weak var plainTextFieldView: UIView!
    @IBOutlet weak var mobileTextFieldView: UIView!
    @IBOutlet weak var formTextfield: UITextField!
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var countryCodeField: UITextField!
    @IBOutlet weak var phoneNumberCodeField: UITextField!
    
    //MARK: - Properties
    var onValueSelected: ((Int, String) -> Void)?
    var isExpaned: ((Bool) -> ())?
    var formItem:FormItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func SignUpConfigureUI(){
        
        if formItem?.isRequired == true {
            let attr = NSMutableAttributedString(string: formItem?.title ?? "",
                                                 attributes: [.foregroundColor: AppTheme.primaryTextColor, .font: AppFonts.Regular(size: 12.0)])
            
            attr.append(NSAttributedString(
                string: " *",
                attributes: [.foregroundColor: UIColor.red, .font: AppFonts.Regular(size: 12.0)]
            ))
            fieldTitleLabel.attributedText = attr
        } else {
            let attr = NSMutableAttributedString(string: formItem?.title ?? "",
                                                 attributes: [.foregroundColor: AppTheme.primaryTextColor, .font: AppFonts.Regular(size: 12.0)])
            fieldTitleLabel.attributedText = attr
            
        }
        if formItem?.fieldType == .phone{
            mobileTextFieldView.isHidden = false
            plainTextFieldView.isHidden = true
            
            countryCodeField.text = "+91"
            if formItem?.value?.isEmpty == true {
                phoneNumberCodeField.placeholder = formItem?.placeholder ?? ""
            }else{
                if let value = formItem?.value, !value.isEmpty {
                    phoneNumberCodeField.text = value
                    formItem?.value = value
                }
            }
            
            phoneNumberCodeField.layer.cornerRadius = 10
            phoneNumberCodeField.layer.borderWidth = 1.5
            phoneNumberCodeField.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            phoneNumberCodeField.layer.masksToBounds = true
            
            countryCodeField.layer.cornerRadius = 10
            countryCodeField.layer.borderWidth = 1.5
            countryCodeField.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            countryCodeField.layer.masksToBounds = true
        }else{
            mobileTextFieldView.isHidden = true
            plainTextFieldView.isHidden = false
            
            if formItem?.value?.isEmpty == true || formItem?.value == nil {
                formTextfield.placeholder = formItem?.placeholder ?? ""
            }else{
                if let value = formItem?.value, !value.isEmpty {
                    formTextfield.text = value
                    formItem?.value = value
                }
            }
            
            dropDownButton.isHidden = !(formItem?.showDropDown ?? false)
            
            formTextfield.layer.cornerRadius = 10
            formTextfield.layer.borderWidth = 1.5
            formTextfield.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            formTextfield.layer.masksToBounds = true
        }
    }
    
    func SignInConfigureUI(title:String, placeholderText:String) {
        let attr = NSMutableAttributedString(string: title,
                                             attributes: [.foregroundColor: AppTheme.primaryTextColor, .font: AppFonts.Regular(size: 12.0)])
        
        attr.append(NSAttributedString(
            string: " *",
            attributes: [.foregroundColor: UIColor.red, .font: AppFonts.Regular(size: 12.0)]
        ))
        fieldTitleLabel.attributedText = attr
        formTextfield.placeholder = placeholderText
        
        formTextfield.layer.cornerRadius = 10
        formTextfield.layer.borderWidth = 1.5
        formTextfield.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        formTextfield.layer.masksToBounds = true
        dropDownButton.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func didTapOnDropDown(_ sender: UIButton) {
        sender.isSelected.toggle()
        self.isExpaned?(sender.isSelected)
    }
}
