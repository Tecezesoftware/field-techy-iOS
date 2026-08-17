//
//  OTPScreenVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 13/08/26.
//

import UIKit

enum otpFieldType {
    case applogo
    case text
    case withpassword
    case submitButton
    case socialLogin
}

class OTPScreenVC: UIViewController {
    
    //MARK: - Outlet Property
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var otpTableView: UITableView!

    //MARK: - Properties
    var otpFields: [otpFieldType] = [.applogo, .text, .withpassword, .submitButton, .socialLogin]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgView.layer.cornerRadius = bgView.frame.height/2
        registerCell()
    }
    
    func registerCell(){
        Singleton.shared.register(in: otpTableView, nameOfAllCells: ["SignupApplogoCell", "TextFieldCell", "ForgotPasswordCell", "CompleteButtonCell", "SocialLoginCell"])
    }
}

extension OTPScreenVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return otpFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch otpFields[indexPath.row] {
        case .applogo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SignupApplogoCell", for: indexPath) as! SignupApplogoCell
            cell.titleLabel.text = "Sign In"
            return cell
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.SignInConfigureUI(title: "Email ID", placeholderText: "Enter Your Email ID")
            return cell
        case .withpassword:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForgotPasswordCell", for: indexPath) as! ForgotPasswordCell
            cell.forgotPasswordButton.isHidden = true
            let attr = NSMutableAttributedString(string: "Sign in with ",
                                                 attributes: [.foregroundColor: AppTheme.primaryTextColor, .font: AppFonts.Regular(size: 12.0)])
            
            attr.append(NSAttributedString(
                string: " Password",
                attributes: [.foregroundColor: AppTheme.primaryButtonTextColor, .font: AppFonts.SemiBold(size: 12.0)]
            ))
            cell.sendOTPButton.setAttributedTitle(attr, for: .normal)
            
            cell.navigateToOTP = {[weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            
            return cell
        case .submitButton:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteButtonCell", for: indexPath) as! CompleteButtonCell
            cell.buttonLabel.text = "Send OTP"
            cell.navigateToRespectiveScreen = {[weak self] in
                let vc = Singleton.shared.storyBoard(storyboard: "OTPVerification", identifier: "OTPVerificationVC")
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        case .socialLogin:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SocialLoginCell", for: indexPath) as! SocialLoginCell
            cell.signInLabel.text = "Don't have an account? "
            cell.signInButton.setTitle("Sign Up", for: .normal)
            
            cell.navigateToRespectiveView = {[weak self] in
                let vc = Singleton.shared.storyBoard(storyboard: "SignUp", identifier: "SignUpView")
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch otpFields[indexPath.row] {
        case .applogo : return 122
        case .text : return 84
        case .withpassword: return 34
        case .submitButton : return 61
        case .socialLogin: return 160
        }
    }
}
