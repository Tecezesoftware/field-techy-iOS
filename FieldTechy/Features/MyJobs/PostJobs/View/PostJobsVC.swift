//
//  PostJobsVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 31/08/26.
//


import UIKit

class PostJobsVC: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var queryBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewFooter: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var termsAndContBtn: UIButton!
    
    var formItems = jobsFormDataSource.makeItems()
    var dropDown = DropDown()
    var selectedJobType : jobTypes = .dispatch
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RegisterCells()
        
        cancelBtn.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        cancelBtn.layer.borderWidth = 1
    }
    
    func RegisterCells(){
        Singleton.shared.register(in: tableView, nameOfAllCells: ["CheckListCell", "CostBreakdownCell", "DocsUploadCell", "EngineerInfoCell", "JobModeCell", "JobsTextFieldCell", "JobsTextFieldWithDDCell", "JobTypeCell", "LabelWithToggleCell", "EmptyCell"])
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
    
    @IBAction func queryAction(_ sender: Any) {
        
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
    
    @IBAction func postJob(_ sender: Any) {
        //TODO: - Call Posted job API
        print ("Job Posted..... ")
        let vc = Singleton.shared.storyBoard(storyboard: "PaymentSelection", identifier: "PaymentSelectionVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PostJobsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return formItems.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "postJobsHeaderCell", for: indexPath) as! postJobsHeaderCell
            cell.onTapJobs = { [weak self] type in
                self?.selectedJobType = type
                self?.tableView.reloadData()
            }
            return cell
        }else{
            
            let item = formItems[indexPath.row - 1]
            switch item.type{
            case .text, .phoneNumber:
                let cell = tableView.dequeueReusableCell(withIdentifier: "JobsTextFieldCell", for: indexPath) as! JobsTextFieldCell
                cell.configureUI(isRequired: item.isRequired, title: item.title ?? "", placeHolder: item.placeholder ?? "")
                cell.textFieldHeight.constant = 47
                return cell
                
            case .JD:
                let cell = tableView.dequeueReusableCell(withIdentifier: "JobsTextFieldCell", for: indexPath) as! JobsTextFieldCell
                cell.configureUI(isRequired: item.isRequired, title: item.title ?? "", placeHolder: item.placeholder ?? "")
                cell.textFieldHeight.constant = 144
                return cell
                
            case .dropDown, .multiChoice:
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
                
            case .buttonStack:
                let cell = tableView.dequeueReusableCell(withIdentifier: "JobModeCell", for: indexPath) as! JobModeCell
                cell.refreshCell = {[weak self] in
                    self?.tableView.reloadRows(at: [indexPath], with: .none)
                }
                return cell
                
            case .toggle:
                let cell = tableView.dequeueReusableCell(withIdentifier: "LabelWithToggleCell", for: indexPath) as! LabelWithToggleCell
                return cell
                
            case .engData:
                let cell = tableView.dequeueReusableCell(withIdentifier: "EngineerInfoCell", for: indexPath) as! EngineerInfoCell
                cell.configureUI(jobType: selectedJobType)
                return cell
                
            case .checklist:
                guard selectedJobType == .dispatch else{
                    return tableView.dequeueReusableCell(withIdentifier: "EmptyCell", for: indexPath) as! EmptyCell
                }
                let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListCell", for: indexPath) as! CheckListCell
                return cell
            case .upload:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DocsUploadCell", for: indexPath) as! DocsUploadCell
                return cell
            case .cost:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CostBreakdownCell", for: indexPath) as! CostBreakdownCell
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
                return 61 // Header height
        }else{
            
            switch formItems[indexPath.row - 1].type{
            case .text, .phoneNumber, .dropDown, .multiChoice:
                if formItems[indexPath.row].id == 5, selectedJobType == .dispatch{
                    return 0
                }else{
                    return 90
                }
            case .JD: return 187
            case .buttonStack: return 83
            case .toggle: return 36
            case .engData:
                switch selectedJobType{
                case .dispatch: return 963
                case .fulltime: return 1050
                case .scheduled: return 1398
                }
            case .checklist:
                if selectedJobType == .dispatch{
                    return 219
                }
                return 0
            case .upload: return 159
            case .cost: return 275
            }
        }
    }
}

//MARK: - Post Jobs HeaderCell

class postJobsHeaderCell: UITableViewCell {
    
    @IBOutlet weak var dispatchBtn: UIButton!
    @IBOutlet weak var fullTimeBtn: UIButton!
    @IBOutlet weak var scheduledBtn: UIButton!
    
    var defaultSelectedTag = 0
    var onTapJobs: ((jobTypes) -> ())?
    var jobtypeButton: [UIButton] {
        [dispatchBtn, fullTimeBtn, scheduledBtn]
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        jobtypeButton.forEach {
            $0.layer.cornerRadius = $0.bounds.height / 2
        }
        
        fullTimeBtn.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        fullTimeBtn.layer.borderWidth = 1
        
        scheduledBtn.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        scheduledBtn.layer.borderWidth = 1
    }
    
    private func configure(_ buttons: [UIButton], isSelected: [UIButton:Bool]) {
        for button in buttons{
            guard let isSelected = isSelected[button] else { return }
            button.isSelected = isSelected
            button.backgroundColor = isSelected ? AppTheme.brandPrimaryTint : .clear
            button.setTitleColor(isSelected ? AppTheme.primaryButtonBGColor: AppTheme.primaryTextColor, for: .normal)
            button.layer.borderColor = !isSelected ? AppTheme.borderColorOfViews.cgColor : UIColor.clear.cgColor
            button.layer.borderWidth = !isSelected ? 1 : 0
        }
    }
    
    @IBAction func onTapJobs(_ sender: UIButton) {
        if sender.tag == 0 {
            onTapJobs?(.dispatch)
            fullTimeBtn.isSelected = false
            scheduledBtn.isSelected = false
        }else if sender.tag == 1 {
            onTapJobs?(.fulltime)
            dispatchBtn.isSelected = false
            scheduledBtn.isSelected = false
        }else if sender.tag == 2{
            onTapJobs?(.scheduled)
            fullTimeBtn.isSelected = false
            dispatchBtn.isSelected = false
        }
        sender.isSelected = true
        configure(jobtypeButton, isSelected: [dispatchBtn: dispatchBtn.isSelected, fullTimeBtn: fullTimeBtn.isSelected, scheduledBtn: scheduledBtn.isSelected])
    }
}
