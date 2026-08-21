//
//  EngineerStep3VC.swift
//  FieldTechy
//
//  Created by Kowsalya on 20/08/26.
//

import UIKit

class EngineerStep3VC: BaseStepVC {
    
    var formItems = EngineerFormDataSource.step3Items()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure(){
        showBackButton(false)          // Step 1 — no back
        setContinueTitle("Complete Registration")
    }
    
    override func registerCells(){
        Singleton.shared.register(in: tableView, nameOfAllCells: ["SectionHeaderCell", "TextFieldCell", "ToggleCell", "SocialLoginCell", "EmptyCell"])
    }
    
    override func continueTapped() {
        view.endEditing(true)
        saveToModel()
        (parent as? EngineerSignUpContainerVC)?.goToNextStep()
    }
    
    private func saveToModel() {
        formItems.forEach { item in
            switch item.title {
            case "jobRadius":  sharedModel.jobRadiusKm       = item.value
            case "accountNumber":  sharedModel.accountNumber      = item.value
            case "accountHolder":  sharedModel.accountHolderName  = item.value
            case "bankName":       sharedModel.bankName           = item.value
            case "ifscCode":       sharedModel.ifscCode           = item.value
            case "branchName":     sharedModel.branchName         = item.value
            default: break
            }
        }
    }
    
    private let preferenceRows: [ToggleRowItem] = [
        ToggleRowItem(id: "onsiteJobs", title: "Onsite jobs",          subtitle: "Accept jobs at client locations",  isOn: true),
        ToggleRowItem(id: "remoteJobs", title: "Remote jobs",          subtitle: "Accept work-from-home jobs",       isOn: true),
        ToggleRowItem(id: "travel",     title: "Willing to travel",    subtitle: "Open to travel when required",     isOn: false),
        ToggleRowItem(id: "dispatch",   title: "Dispatch (urgent)",    subtitle: "Same-day job requests",            isOn: false),
        ToggleRowItem(id: "fullTime",   title: "Full-time contracts",  subtitle: "Multi-week engagements",           isOn: false),
        ToggleRowItem(id: "pushNotif",  title: "Push Notifications",   subtitle: "Get alerted for new jobs",        isOn: true)
    ]
    
}

extension EngineerStep3VC{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch formItems[indexPath.row].fieldType {
        case .sectionHeader:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SectionHeaderCell", for: indexPath) as! SectionHeaderCell
            cell.titleLabel.text = formItems[indexPath.row].title
            return cell
        case .toggleGroup:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToggleCell", for: indexPath) as! ToggleCell
            return cell
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.engineerFormItem = formItems[indexPath.row]
            cell.configureEngineerSignUpUI()
            return cell
        case .socialLogin:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SocialLoginCell", for: indexPath) as! SocialLoginCell
            return cell
        default :
            return tableView.dequeueReusableCell(withIdentifier: "EmptyCell") as! EmptyCell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch formItems[indexPath.row].fieldType{
        case .sectionHeader: return 27.0
        case .toggleGroup: return 546.0
        case .text: return 84.0
        case .socialLogin: return 160.0
        default: return 0.0
        }
    }
}

//cell.onToggleChanged = { [weak self] id, isOn in
//        guard let self else { return }
//        // Update model
//        switch id {
//        case "onsiteJobs": self.sharedModel.onsiteJobs        = isOn
//        case "remoteJobs": self.sharedModel.remoteJobs        = isOn
//        case "travel":     self.sharedModel.willingToTravel   = isOn
//        case "dispatch":   self.sharedModel.dispatchUrgent    = isOn
//        case "fullTime":   self.sharedModel.fullTimeContracts = isOn
//        case "pushNotif":  self.sharedModel.pushNotifications = isOn
//        default: break
//        }
//        print("✅ \(id) → \(isOn)")
