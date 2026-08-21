//
//  EngineerStep2VC.swift
//  FieldTechy
//
//  Created by Kowsalya on 18/08/26.
//

import UIKit

class EngineerStep2VC: BaseStepVC {
    
    var formItems = EngineerFormDataSource.step2Items()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        registerCells()
    }
    
    override func configure(){
        showBackButton(true)
        setContinueTitle("Continue")
    }
    
    override func registerCells(){
        Singleton.shared.register(in: tableView, nameOfAllCells: ["SectionHeaderCell", "TextFieldCell", "MultiSelectChipsCell", "CapturePhotoCell", "DatePickerCell", "SocialLoginCell", "EmptyCell"])
    }
    
    override func continueTapped() {
        view.endEditing(true)
        saveToModel()
        (parent as? EngineerSignUpContainerVC)?.goToNextStep()
    }
    
    private func saveToModel() {
        formItems.forEach { item in
            switch item.id {
            case "skills":      sharedModel.selectedSkills  = item.selectedValues
            case "skillLevel":  sharedModel.skillLevel      = item.value
            case "experience":  sharedModel.totalExperience = item.value
            case "minRate":     sharedModel.minHourlyRate   = item.value
            case "maxRate":     sharedModel.maxHourlyRate   = item.value
            case "tools":       sharedModel.availableTools  = item.selectedValues
            default: break
            }
        }
    }
}

extension EngineerStep2VC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch formItems[indexPath.row].fieldType {
        case .sectionHeader:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SectionHeaderCell", for: indexPath) as! SectionHeaderCell
            cell.titleLabel.text = formItems[indexPath.row].title
            return cell
        case .multiSelectChips/*(let options)*/:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.engineerFormItem = formItems[indexPath.row]
            cell.configureEngineerSignUpUI()
//            cell.appendChips(options)
            return cell
        case .text, .rateField:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.engineerFormItem = formItems[indexPath.row]
            cell.configureEngineerSignUpUI()
            return cell
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CapturePhotoCell", for: indexPath) as! CapturePhotoCell
            return cell
        case .datePicker:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell", for: indexPath) as! DatePickerCell
            cell.engineerFormItem = formItems[indexPath.row]
            cell.configureUI()
            return cell
        case .socialLogin:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SocialLoginCell", for: indexPath) as! SocialLoginCell
            return cell
        default:
            return tableView.dequeueReusableCell(withIdentifier: "EmptyCell") as! EmptyCell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch formItems[indexPath.row].fieldType{
        case .sectionHeader: return 27.0
        case .multiSelectChips, .text, .rateField, .datePicker: return 84.0
        case .photo: return 161.0
        case .socialLogin: return 160.0
        default: return 0.0
        }
    }
}
