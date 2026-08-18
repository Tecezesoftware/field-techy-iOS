//
//  SignUpVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 06/08/26.
//

import Foundation
import UIKit

class SignUpVC: UIViewController{
    
    //MARK: - IBOutlet Properties
    @IBOutlet weak var signUpTableView: UITableView!
    
    //MARK: - Properties
    var formItems = SignUpFormDataSource.makeItems()
    var dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        registerCell()
        setupKeyboard()
    }
    
    func tableViewSetup(){
        signUpTableView.contentInsetAdjustmentBehavior = .never
        signUpTableView.contentInset = .zero
        signUpTableView.scrollIndicatorInsets = .zero
        signUpTableView.sectionHeaderTopPadding = 0
    }
    
    func registerCell(){
        let cells = ["SignUpBannerCell", "SignupApplogoCell", "TextFieldCell", "CapturePhotoCell", "PrivacyPolicyCell", "SocialLoginCell", "CompleteButtonCell"]
        Singleton.shared.register(in: signUpTableView, nameOfAllCells: cells)
    }
    
    // MARK: - Keyboard
    private func setupKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        signUpTableView.contentInset.bottom = frame.height
    }

    @objc private func keyboardWillHide() {
        signUpTableView.contentInset.bottom = 0
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func showDropDrown(anchorView: TextFieldCell, options:[String]){
        dropDown.show(
            options: options,
            placeholder: "placeholder",
            anchorView: anchorView.formTextfield,
            in: self
        )
    }
    
    func hideDropDown(){
        dropDown.dismiss()
    }
}

extension SignUpVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        formItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = formItems[indexPath.row]
        switch item.fieldType{
            
        case .banner:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SignUpBannerCell", for: indexPath) as! SignUpBannerCell
            return cell
            
        case .logo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SignupApplogoCell", for: indexPath) as! SignupApplogoCell
            return cell
            
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.formItem = item
            cell.SignUpConfigureUI()
            
            cell.isExpaned = {[weak self] isExpandDropDown in
                if isExpandDropDown {
                    self?.showDropDrown(anchorView: cell, options: item.dropDownOptions)
                    self?.dropDown.onSelect = { [weak self] index, value in
                        self?.formItems[indexPath.row].value = value
                        cell.formTextfield.text = value
                    }
                } else {
                    self?.dropDown.dismiss()
                }
            }
            return cell
            
        case .phone:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.formItem = item
            cell.SignUpConfigureUI()
            return cell
            
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CapturePhotoCell", for: indexPath) as! CapturePhotoCell
            return cell
            
        case .password:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.formItem = item
            cell.SignUpConfigureUI()
            return cell
            
        case .terms:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PrivacyPolicyCell", for: indexPath) as! PrivacyPolicyCell
            return cell
            
        case .socialLogin:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SocialLoginCell", for: indexPath) as! SocialLoginCell
            cell.navigateToRespectiveView = {[weak self] in
                let vc = Singleton.shared.storyBoard(storyboard: "SignIn", identifier: "SignInVC")
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
            
        case .submitButton:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteButtonCell", for: indexPath) as! CompleteButtonCell
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = formItems[indexPath.row]
        switch item.fieldType{
        case .banner: return 180
        case .logo : return 122
        case .text, .password, .phone : return 84
        case .photo : return 161
        case .terms: return 57
        case .socialLogin: return 160
        case .submitButton: return 100
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
