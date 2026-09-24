//
//  AccountSecurityVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 23/09/26.
//

import UIKit

class AccountSecurityVC: UIViewController {
    
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var currentPassField: UITextField!
    @IBOutlet weak var newPassField: UITextField!
    @IBOutlet weak var conformtPassField: UITextField!
    
    @IBOutlet weak var authView: UIView!
    @IBOutlet weak var authInfoView: UIView!
    @IBOutlet weak var otpStackView: UIStackView!
    
    @IBOutlet weak var deleteAccountView: UIView!
    @IBOutlet weak var alertView: UIView!
    
    
    private var otpFields: [OTPSingleTextField] = []
    private let otpLength       = 6
    
    private var views: [UIView]{
        [
            changePasswordView,
            authView,
            deleteAccountView
        ]
    }
    
    private var fields: [UITextField]{
        [
            currentPassField,
            newPassField,
            conformtPassField
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOTPFields()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in views{
            view.layer.cornerRadius = 10
            view.layer.borderWidth = 1
            view.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        }
        
        for field in fields {
            field.layer.cornerRadius = 10
            field.layer.borderWidth = 1.5
            field.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            field.layer.masksToBounds = true
        }
        
        authInfoView.layer.cornerRadius = 10
        authInfoView.layer.borderWidth = 1
        authInfoView.layer.borderColor = AppTheme.brandPrimaryTint.cgColor
        
        alertView.layer.cornerRadius = 10
        alertView.layer.borderWidth = 1
        alertView.layer.borderColor = AppTheme.error200.cgColor
    }
    
    // MARK: - OTP Fields Setup
    private func setupOTPFields() {
        for i in 0..<otpLength {
            let field = OTPSingleTextField()
            field.tag         = i
            field.otpDelegate = self
            otpFields.append(field)
            otpStackView.addArrangedSubview(field)
        }
    }
    
    // MARK: - OTP Helpers
    private func getOTP() -> String {
        otpFields.compactMap { $0.text }.joined()
    }
    
    private func clearAllFields() {
        otpFields.forEach {
            $0.text = ""
            $0.resetState()
        }
        otpFields.first?.becomeFirstResponder()
    }
    
    private func shakeAndShowError() {
        otpFields.forEach { $0.setErrorState() }
        
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.5
        animation.values   = [-10, 10, -8, 8, -5, 5, 0]
        otpStackView.layer.add(animation, forKey: "shake")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.clearAllFields()
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func queryAction(_ sender: Any){
        let vc = Singleton.shared.storyBoard(storyboard: "RaiseDispute", identifier: "RaiseDisputeVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension AccountSecurityVC : OTPSingleTextFieldDelegate {
    func otpFieldDidChange(_ field: OTPSingleTextField) {
        guard let text = field.text, !text.isEmpty else { return }
        field.setFilledState()
        
        let next = field.tag + 1
        if next < otpLength {
            otpFields[next].becomeFirstResponder()
        } else {
            field.resignFirstResponder()
            let otp = getOTP()
            if otp.count == otpLength {
                print("✅ OTP complete: \(otp)")
                // viewModel.verifyOTP(otp: otp)
            }
        }
    }
    
    func otpFieldDidDelete(_ field: OTPSingleTextField) {
        field.resetState()
        let prev = field.tag - 1
        if prev >= 0 {
            otpFields[prev].text = ""
            otpFields[prev].resetState()
            otpFields[prev].becomeFirstResponder()
        }
    }
}
