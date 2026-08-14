//
//  OTPVerificationVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 13/08/26.
//

enum otpVerficationFieldType {
    case logo
    case otpVerifyField
    case submitButton
    case socialLogin
}

import UIKit

class OTPVerificationVC: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var otpVerifyTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func registerCell(){
        Singleton.shared.register(in: otpVerifyTableView, nameOfAllCells: ["SignupApplogoCell", "CompleteButtonCell", "SocialLoginCell"])
    }
}
