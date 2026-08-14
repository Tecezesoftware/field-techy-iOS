//
//  PhoneNumberTextFieldCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 07/08/26.
//

import UIKit

class PhoneNumberTextFieldCell: UITableViewCell {

    @IBOutlet weak var fieldTitleLabel: UILabel!
    @IBOutlet weak var countryCodeField: UITextField!
    @IBOutlet weak var phoneNumberCodeField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureUI(fieldTitle: String, placeholderText: String, isThisFieldRequired:Bool){
        if isThisFieldRequired {
            let attr = NSMutableAttributedString(string: fieldTitle)
            attr.append(NSAttributedString(
                string: " *",
                attributes: [.foregroundColor: UIColor.red]
            ))
            fieldTitleLabel.attributedText = attr
        } else {
            fieldTitleLabel.text = fieldTitle
        }
        countryCodeField.text = "+91"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
