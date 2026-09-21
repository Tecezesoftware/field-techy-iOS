//
//  RaiseDisputeVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 17/09/26.
//

import UIKit

class RaiseDisputeVC: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewFooter: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var termsAndContBtn: UIButton!
    
    var formItems = disputeFormDataSource.makeItems()
    var dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RegisterCells()
        
        cancelBtn.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        cancelBtn.layer.borderWidth = 1
    }
    
    func RegisterCells(){
        Singleton.shared.register(in: tableView, nameOfAllCells: ["DocsUploadCell", "JobsTextFieldCell", "JobsTextFieldWithDDCell", "FilesCell", "EmptyCell"])
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
        tableView.contentInset.bottom = frame.height
    }

    @objc private func keyboardWillHide() {
        tableView.contentInset.bottom = 0
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func showDropDrown(anchorView: JobsTextFieldWithDDCell, options:[String]){
        dropDown.show(
            options: options,
            placeholder: "placeholder",
            anchorView: anchorView.dropDownField,
            in: self
        )
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onTapTC(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            
            termsAndContBtn.setImage(UIImage(named: "CheckIcon"), for: .normal)
            
            submitBtn.isEnabled = true
            submitBtn.backgroundColor = AppTheme.primaryButtonBGColor
            submitBtn.setTitleColor(AppTheme.secondaryBGColor, for: .normal)
        }else{
            termsAndContBtn.setImage(UIImage(named: "UncheckIcon"), for: .normal)
            
            submitBtn.isEnabled = false
            submitBtn.backgroundColor = AppTheme.neutralLight200
            submitBtn.setTitleColor(AppTheme.neutralLight800, for: .normal)
        }
    }
    
    @IBAction func postDispute(_ sender: Any) {
        //TODO: - Call Posted Dispute API
        let vc = Singleton.shared.storyBoard(storyboard: "ViewDispute", identifier: "ViewDisputeVC") as! ViewDisputeVC
        vc.isFromRasieIssue = true
        self.navigationController?.pushViewController(vc, animated: true)
        print ("Dispute Posted..... ")
        
    }
}

extension RaiseDisputeVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = formItems[indexPath.row]
        switch item.type{
        case .text, .phoneNumber:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobsTextFieldCell", for: indexPath) as! JobsTextFieldCell
            cell.configureUI(isRequired: item.isRequired, title: item.title ?? "", placeHolder: item.placeholder ?? "")
            cell.textFieldHeight.constant = 47
            return cell
            
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobsTextFieldCell", for: indexPath) as! JobsTextFieldCell
            cell.configureUI(isRequired: item.isRequired, title: item.title ?? "", placeHolder: item.placeholder ?? "")
            cell.textFieldHeight.constant = 144
            return cell
            
        case .dropDown:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobsTextFieldWithDDCell", for: indexPath) as! JobsTextFieldWithDDCell
            cell.configureUI(isRequired: item.isRequired, title: item.title ?? "", placeHolder: item.placeholder ?? "")
            cell.isExpaned = {[weak self] isExpandDropDown in
                if isExpandDropDown {
                    self?.showDropDrown(anchorView: cell, options: item.options ?? [])
                    self?.dropDown.onSelect = { index, value in
                        print("Selected value: \(value)")
                        cell.dropDownField.text = value
                    }
                } else {
                    self?.dropDown.dismiss()
                }
            }
            return cell
        case .upload:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DocsUploadCell", for: indexPath) as! DocsUploadCell
            return cell
        case .file:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilesCell", for: indexPath) as! FilesCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = formItems[indexPath.row]
        switch formItems[indexPath.row].type{
        case .text, .dropDown, .phoneNumber: return  90.0
        case .description: return 187.0
        case .upload: return  146.0
        case .file: return  97.0
        }
    }
}
