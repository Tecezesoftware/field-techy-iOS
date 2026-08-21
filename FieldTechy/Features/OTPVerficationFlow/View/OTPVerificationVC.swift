//
//  OTPVerificationVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 13/08/26.
//

import UIKit

class OTPVerificationVC: UIViewController {

    //MARK: - Outlet Property
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var otpStackView: UIStackView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var resendOTPButton: UIButton!
    @IBOutlet weak var signInButtonView: UIView!
    
    //MARK: - Properties
    var email: String  = "johndoe@gmail.com"
    private var otpFields: [OTPSingleTextField] = []
    private let otpLength       = 6
    private var timer: Timer?
    private var remainingSeconds = 60

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureUI()
        setupOTPFields()
        startTimer()
    }
    //MARK: - Setup UI
    func ConfigureUI() {
        
        let attr = NSMutableAttributedString(string: "Enter the 6 digit verification code sent to your ",
                                             attributes: [.foregroundColor: AppTheme.primaryTextColor, .font: AppFonts.Regular(size: 12.0)])
        
        attr.append(NSAttributedString(
            string: email,
            attributes: [.foregroundColor: AppTheme.primaryTextColor, .font: AppFonts.SemiBold(size: 12.0)]
        ))
        
        titleLable.attributedText = attr
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
    // MARK: - Timer
    private func startTimer() {
        remainingSeconds   = 60
        resendOTPButton.isEnabled = false
        updateTimerLabel()
        
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true
        ) { [weak self] _ in
            guard let self else { return }
            self.remainingSeconds -= 1
            self.updateTimerLabel()
            
            if self.remainingSeconds <= 0 {
                self.stopTimer()
                self.timerLabel.text   = "00:00"
                self.resendOTPButton.isEnabled = true
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateTimerLabel() {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
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
    
    @IBAction func resendOtpAction(_ sender: Any) {
        clearAllFields()
        startTimer()
        print("Resend OTP API call → \(email)")
    }
    
    @IBAction func navigateToSignup(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "SignUp", identifier: "SignUpVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func navigateToSignIn(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "SignIn", identifier: "SignInVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension OTPVerificationVC: OTPSingleTextFieldDelegate {
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
