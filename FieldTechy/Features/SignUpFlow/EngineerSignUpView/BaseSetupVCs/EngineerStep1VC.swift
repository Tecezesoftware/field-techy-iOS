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
    
    func configure(){
        tableView.delegate = self
        tableView.dataSource = self
        backButtonView.isHidden = true
    }
    
    func registerCells(){
        Singleton.shared.register(in: tableView, nameOfAllCells: ["SectionHeaderCell", "TextFieldCell", "SplitTextFieldCell", "CapturePhotoCell", "SocialLoginCell"])
    }
    
    func continueTapped() {
        view.endEditing(true)
        saveToModel()
        guard validateStep() else { return }
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
}

extension EngineerStep1VC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch formItems[indexPath.row].id {
        case "sectionTitle":
            let cell = tableView.dequeueReusableCell(withIdentifier: "SectionHeaderCell", for: indexPath) as! SectionHeaderCell
            cell.titleLabel.text = formItems[indexPath.row].title
            return cell
        case "firstName":
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.engineerFormItem = formItems[indexPath.row]
        case "middleName":
        case "lastName":
        case "email":
        case "mobile":
        case "address":
        case "city":
        case "postalCodeAndCountry":
        case "photo":
        case "password":
        case "socialLogin":
        default:
            break 
        }
    }
}
