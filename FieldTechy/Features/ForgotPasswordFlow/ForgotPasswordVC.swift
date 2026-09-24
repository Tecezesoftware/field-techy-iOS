 //
//  ForgotPasswordVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 14/08/26.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var emailIdField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailIdField.delegate = self
        configureUI()
    }
    
    func configureUI(){
        emailIdField.layer.cornerRadius = 10
        emailIdField.layer.borderWidth = 1.5
        emailIdField.layer.masksToBounds = true
        emailIdField.placeholder = "Enter Your Email ID"
        emailIdField.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        emailIdField.layer.backgroundColor = AppTheme.fieldBGColor.cgColor
    }
    
    func validatation(){
        emailIdField.text = ""
        emailIdField.placeholder = "Enter Your Email ID"
        emailIdField.layer.borderColor = AppTheme.error800.cgColor
        emailIdField.layer.backgroundColor = AppTheme.error100.cgColor
        
        errorLabel.isHidden = false
        errorLabel.text = "Please enter valid email id"
        errorLabel.textColor = AppTheme.error800
    }

    @IBAction func onTapEmailBtnAction(_ sender: Any) {
        if emailIdField.text?.isEmpty == false {
            //TODO: - In Future need to verify link shared in email then only we need to redirect to resetpassword vc
            let vc = Singleton.shared.storyBoard(storyboard: "ResetPassword", identifier: "ResetPasswordVC")
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            validatation()
        }
    }
    
    @IBAction func navigateToSignIn(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "signIn", identifier: "signInVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ForgotPasswordVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func didChangeValue(forKey key: String) {
        emailIdField.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        emailIdField.layer.backgroundColor = AppTheme.fieldBGColor.cgColor
        
        errorLabel.isHidden = true
        errorLabel.text = ""
    }
}
