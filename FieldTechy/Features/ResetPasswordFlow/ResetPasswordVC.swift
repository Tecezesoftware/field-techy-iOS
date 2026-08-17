//
//  ResetPasswordVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 14/08/26.
//

import UIKit

class ResetPasswordVC: UIViewController {

    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureUI(){
        newPasswordField.layer.cornerRadius = 10
        newPasswordField.layer.borderWidth = 1.5
        newPasswordField.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        newPasswordField.layer.masksToBounds = true
        newPasswordField.placeholder = "••••••••••••"
        
        confirmPasswordField.layer.cornerRadius = 10
        confirmPasswordField.layer.borderWidth = 1.5
        confirmPasswordField.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        confirmPasswordField.layer.masksToBounds = true
        confirmPasswordField.placeholder = "••••••••••••"
    }
    @IBAction func onTapSigninBtnAction(_ sender: Any) {
        
    }
    @IBAction func navigateToSignUp(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "SignUp", identifier: "SignUpVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
