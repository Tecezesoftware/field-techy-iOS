//
//  EngineerStep1VC.swift
//  FieldTechy
//
//  Created by Kowsalya on 18/08/26.
//

import UIKit

class EngineerStep1VC: BaseStepVC {
    
    var formItems = EngineerFormDataSource.step1Items()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        registerCells()
    }
    
    override func configure(){
        showBackButton(false)          // Step 1 — no back
        setContinueTitle("Continue")
    }
    
    override func registerCells(){
        Singleton.shared.register(in: tableView, nameOfAllCells: ["SectionHeaderCell", "TextFieldCell", "SplitTextFieldCell", "CapturePhotoCell", "SocialLoginCell", "EmptyCell"])
    }
    
    override func continueTapped() {
        view.endEditing(true)
        saveToModel()
//        guard validateStep() else { return }
        (parent as? EngineerSignUpContainerVC)?.goToNextStep()
    }

    private func saveToModel() {
        
        formItems.forEach { item in
            switch item.id {
            case "firstName":  sharedModel.firstName  = item.value
            case "lastName":   sharedModel.lastName   = item.value
            case "email":      sharedModel.email      = item.value
            case "mobile":     sharedModel.mobile     = item.value
            case "address":    sharedModel.address    = item.value
            case "city":       sharedModel.city       = item.value
            case "postalCodeAndCountry": sharedModel.postalCode = item.value
            case "password":   sharedModel.password   = item.value
            default: break
            }
        }
    }

    private func validateStep() -> Bool {
        for item in formItems where item.isRequired && item.value.isEmpty {
            print("❌ \(item.title) is required")
            return false
        }
        return true
    }
    
    func showDropDrown(anchorView: SplitTextFieldCell, options:[String]){
        dropDown.show(
            options: options,
            placeholder: "placeholder",
            anchorView: anchorView.field2TextField,
            in: self
        )
    }
}

extension EngineerStep1VC{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch formItems[indexPath.row].fieldType {
        case .sectionHeader:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SectionHeaderCell", for: indexPath) as! SectionHeaderCell
            cell.titleLabel.text = formItems[indexPath.row].title
            return cell
            
        case .text, .email, .phone, .password:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.engineerFormItem = formItems[indexPath.row]
            cell.configureEngineerSignUpUI()
            return cell
            
        case .splitAs2Fields:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SplitTextFieldCell", for: indexPath) as! SplitTextFieldCell
            cell.configureUI()
            cell.engineerFormItem = formItems[indexPath.row]
            cell.isExpaned = {[weak self] isExpandDropDown in
                if isExpandDropDown {
                    self?.showDropDrown(anchorView: cell, options: self?.formItems[indexPath.row].dropDownOptions ?? [])
                    self?.dropDown.onSelect = { [weak self] index, value in
                        self?.formItems[indexPath.row].value = value
                        cell.field2TextField.text = value
                    }
                } else {
                    self?.dropDown.dismiss()
                }
            }
            return cell
            
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CapturePhotoCell", for: indexPath) as! CapturePhotoCell
            return cell
            
        case .socialLogin:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SocialLoginCell", for: indexPath) as! SocialLoginCell
            cell.navigateToRespectiveView = {[weak self] in
                let vc = Singleton.shared.storyBoard(storyboard: "SignIn", identifier: "SignInVC")
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
            
        default:
            return tableView.dequeueReusableCell(withIdentifier: "EmptyCell)") as! EmptyCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch formItems[indexPath.row].fieldType {
        case .sectionHeader: return 27.0
        case .text, .email, .phone, .splitAs2Fields, .password: return 84.0
        case .photo: return 161.0
        case .socialLogin: return 160.0
        default:
            return 0.0
        }
    }
}
