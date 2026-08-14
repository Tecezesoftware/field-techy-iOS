//
//  CompleteButtonCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 10/08/26.
//

import UIKit

class CompleteButtonCell: UITableViewCell {
    
    @IBOutlet weak var buttonLabel: UILabel!
    
    var isSignInButtonAction: Bool = false
    var isSignUpButtonAction: Bool = false
    var isOtpButtonAction: Bool = false
    var isSendEmailButtonAction: Bool = false
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func submitbuttonAction(_ sender: Any) {
        if isSignInButtonAction{
            
        }else if isOtpButtonAction{
            
        }else if isSendEmailButtonAction{
            
        }
    }
}
