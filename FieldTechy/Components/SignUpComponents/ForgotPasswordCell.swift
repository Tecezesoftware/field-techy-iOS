//
//  ForgotPasswordCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 11/08/26.
//

import UIKit

class ForgotPasswordCell: UITableViewCell {
    
    @IBOutlet weak var sendOTPButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    var navigateToOTP: (() -> ())?
    var navigateToForgotPassword: (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func sendOTPButtonAction(_ sender: Any) {
        navigateToOTP?()
    }
    
    @IBAction func forgotPasswordButtonAction(_ sender: Any) {
        navigateToForgotPassword?()
    }
}
