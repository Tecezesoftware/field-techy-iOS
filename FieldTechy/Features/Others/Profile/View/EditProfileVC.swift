//
//  EditProfileVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 22/09/26.
//

import UIKit

class EditProfileVC: UIViewController {

    @IBOutlet weak var profileContainerView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var personalDataContainerView: UIView!
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phnumberField: UITextField!
    @IBOutlet weak var bankAccField: UITextField!
    
    @IBOutlet weak var companyDataContainerView: UIView!
    @IBOutlet weak var companyNameField: UITextField!
    @IBOutlet weak var companyAddressField: UITextField!
    @IBOutlet weak var companyLocationField: UITextField!
    @IBOutlet weak var companyPostalField: UITextField!
    @IBOutlet weak var companyCountryField: UITextField!
    
    @IBOutlet weak var LoginDataContainerView: UIView!
    @IBOutlet weak var loginEmailField: UITextField!
    @IBOutlet weak var oldPasswordField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    @IBOutlet weak var discardBtn: UIButton!
    @IBOutlet weak var changePhotoBottomView: UIView!
    
    
    private var views: [UIView]{
        [
            personalDataContainerView,
            companyDataContainerView,
            LoginDataContainerView
        ]
    }
    
    private var fields: [UITextField]{
        [
            fullNameField,
            emailField,
            phnumberField,
            bankAccField,
            companyNameField,
            companyAddressField,
            companyLocationField,
            companyPostalField,
            companyCountryField,
            loginEmailField,
            oldPasswordField,
            newPasswordField,
            confirmPasswordField
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in views{
            view.layer.cornerRadius = 10
            view.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            view.layer.borderWidth = 1
        }
        
        for field in fields {
            field.layer.cornerRadius = 5
            field.layer.borderWidth = 1.5
            field.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            field.layer.masksToBounds = true
        }
        
        discardBtn.layer.cornerRadius = discardBtn.layer.frame.height / 2
        discardBtn.layer.borderWidth = 1
        discardBtn.layer.borderColor = AppTheme.borderColorOfViews.cgColor
    }
    
    @IBAction func back(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func queryAction(_ sender: Any){
        let vc = Singleton.shared.storyBoard(storyboard: "RaiseDispute", identifier: "RaiseDisputeVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func changeProfile(_ sender: UIButton) {
        sender.isSelected.toggle()
        changePhotoBottomView.isHidden = !sender.isSelected
    }
    
    @IBAction func TakePhoto(_ sender: Any) {
    
    }
    
    @IBAction func ReplacePhoto(_ sender: Any) {
    
    }
    
    @IBAction func RemovePhoto(_ sender: Any) {
    
    }
    
    @IBAction func DiscardAction(_ sender: Any){
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SaveAction(_ sender: Any){
        //TODO: - In future need to call api once profile data was altered.
        self.navigationController?.popViewController(animated: true)
    }
}
