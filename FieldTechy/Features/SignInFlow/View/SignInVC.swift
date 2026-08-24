//
//  SignInVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 11/08/26.
//

import UIKit

enum SignInFieldType {
    case applogo
    case text
    case password
    case forgotPassword
    case submitButton
    case socialLogin
}

class SignInVC: UIViewController {

    //MARK: - Outlet Properties
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var signinTableView: UITableView!
    
    //MARK: - Properties
    var signinFields: [SignInFieldType] = [.applogo, .text, .password, .forgotPassword, .submitButton, .socialLogin]
    var showOtpScreen: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        bgView.layer.cornerRadius = bgView.frame.height/2
        registerCell()
    }
    
    func registerCell(){
        Singleton.shared.register(in: signinTableView, nameOfAllCells: ["SignupApplogoCell", "TextFieldCell", "ForgotPasswordCell", "CompleteButtonCell", "SocialLoginCell"])
    }
}

extension SignInVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return signinFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch signinFields[indexPath.row] {
        case .applogo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SignupApplogoCell", for: indexPath) as! SignupApplogoCell
            cell.titleLabel.text = "Sign In"
            return cell
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.SignInConfigureUI(title: "Email ID", placeholderText: "Enter Your Email ID")
            return cell
        case .password:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.SignInConfigureUI(title: "Password", placeholderText: "••••••••••••")
            return cell
        case .forgotPassword:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForgotPasswordCell", for: indexPath) as! ForgotPasswordCell
            
            let attr = NSMutableAttributedString(string: "Sign in with ",
                                                 attributes: [.foregroundColor: AppTheme.primaryTextColor, .font: AppFonts.Regular(size: 12.0)])
            
            attr.append(NSAttributedString(
                string: " OTP",
                attributes: [.foregroundColor: AppTheme.primaryButtonTextColor, .font: AppFonts.SemiBold(size: 12.0)]
            ))
            cell.sendOTPButton.setAttributedTitle(attr, for: .normal)
            
            
            
            cell.forgotPasswordButton.isHidden = false
            cell.navigateToOTP = {[weak self] in
                let vc = Singleton.shared.storyBoard(storyboard: "OTPScreen", identifier: "OTPScreenVC")
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
            cell.navigateToForgotPassword = {[weak self] in
                let vc = Singleton.shared.storyBoard(storyboard: "ForgotPassword", identifier: "ForgotPasswordVC")
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        case .submitButton:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteButtonCell", for: indexPath) as! CompleteButtonCell
            cell.buttonLabel.text = "Sign in"
            return cell
        case .socialLogin:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SocialLoginCell", for: indexPath) as! SocialLoginCell
            cell.signInLabel.text = "Don't have an account? "
            cell.signInButton.setTitle("Sign Up", for: .normal)
            
            cell.navigateToRespectiveView = {[weak self] in
                let vc = Singleton.shared.storyBoard(storyboard: "RoleSelection", identifier: "RoleSelectionVC")
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch signinFields[indexPath.row] {
        case .applogo : return 122
        case .text, .password : return 84
        case .forgotPassword: return 34
        case .submitButton : return 61
        case .socialLogin: return 160
        }
    }
}
