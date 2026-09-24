//
//  SignInOptionCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 07/08/26.
//

import UIKit

class SocialLoginCell: UITableViewCell {

    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var optionLable: UILabel!
    @IBOutlet weak var socialLoginStackView: UIStackView!
    var navigateToRespectiveView: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func navigateToRespectiveScreen(_ sender: Any) {
        self.navigateToRespectiveView?()
    }
    
    @IBAction func googleLogin(_ sender: Any) {
        
    }
    
    
    @IBAction func linkedInLogin(_ sender: Any) {
        
    }
}
