//
//  ViewDisputeVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 18/09/26.
//

import UIKit

enum disputeTabs{
    case evidence
    case communication
}

class ViewDisputeVC: UIViewController {

    @IBOutlet weak var issueIdLabel: UILabel!
    @IBOutlet weak var jobInfoView: UIView!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var jobLocationLabel: UILabel!
    @IBOutlet weak var jobModeLabel: UILabel!
    @IBOutlet weak var jobTypeView: UIView!
    @IBOutlet weak var jobTypeLabel: UILabel!
    @IBOutlet weak var progressStatusLabel: UILabel!
    @IBOutlet weak var progressPercLabel: UILabel!
    @IBOutlet weak var progressBarOuterView: UIView!
    
    @IBOutlet weak var engineerProfileView: UIView!
    @IBOutlet weak var engineerProfileImageView: UIImageView!
    @IBOutlet weak var engineerNameLabel: UILabel!
    @IBOutlet weak var engineerDesignationLabel: UILabel!
    @IBOutlet weak var engineerRateLabel: UILabel!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var chatButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var evidenceBtn: UIButton!
    @IBOutlet weak var communicationBtn: UIButton!
    @IBOutlet weak var ChatFooter: UIView!
    
    var selectedTab: disputeTabs = .evidence{
        didSet{
            self.tableView.reloadData()
        }
    }
    var isFromRasieIssue:Bool = false
    
    private var communicationButtons:[UIButton] {
        [videoButton,
         callButton,
         chatButton]
    }
    
    private var tabButtons: [UIButton]{
        [
            evidenceBtn,
            communicationBtn
        ]
    }
    var jobType: jobTypes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Configure()
        registerCell()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        jobInfoView.layer.cornerRadius = 5
        jobInfoView.layer.borderWidth = 1.5
        jobInfoView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        jobTypeView.layer.cornerRadius = jobTypeView.frame.height / 2
        
        engineerProfileView.layer.cornerRadius = 5
        engineerProfileView.layer.borderWidth = 1.5
        engineerProfileView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        engineerProfileImageView.layer.cornerRadius = engineerProfileImageView.frame.height / 2
        
        for button in communicationButtons {
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1.5
            button.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        }
    }
    
    func Configure(){
        selectedTab = .evidence
        evidenceBtn.isSelected = true
        configureTabStyle()
        jobTypeLabel.text = jobType?.rawValue
        
    }
    
    func registerCell(){
        Singleton.shared.register(in: tableView, nameOfAllCells: ["EvidenceCell", "CommunicationCell"])
    }
    
    @IBAction func back(_ sender: Any) {
        if isFromRasieIssue{
            let vc = Singleton.shared.storyBoard(storyboard: "Dispute", identifier: "DisputeVC")
            self.navigationController?.pushViewController(vc, animated: false)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func query(_ sender: Any) {
    
    }
    
    @IBAction func viewProfile(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "EngineerProfile", identifier: "EngineerProfileVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showEvidence(_ sender: UIButton) {
        sender.isSelected = true
        communicationBtn.isSelected = false
        ChatFooter.isHidden = true
        selectedTab = .evidence
        configureTabStyle()
    }
    
    @IBAction func showCommunication(_ sender: UIButton) {
        sender.isSelected = true
        evidenceBtn.isSelected = false
        ChatFooter.isHidden = false
        selectedTab = .communication
        configureTabStyle()
    }
    
    func configureTabStyle(){
        for button in tabButtons {
            button.backgroundColor = button.isSelected ? AppTheme.primaryButtonBGColor : .clear
            button.setTitleColor(button.isSelected ? AppTheme.primaryButtonLabelColor : AppTheme.primaryTextColor, for: .normal)
            
            if button.isSelected == false{
                button.layer.cornerRadius = button.layer.frame.height / 2
                button.layer.borderColor = AppTheme.borderColorOfViews.cgColor
                button.layer.borderWidth = 1
            }else{
                button.layer.cornerRadius = button.layer.frame.height / 2
                button.layer.borderWidth = 0
            }
        }
    }
    
    @IBAction func onTapMick(_ sender: Any) {
    
    }
    
    @IBAction func onTapSend(_ sender: Any) {
    
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
}

extension ViewDisputeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedTab == .evidence ? 1 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedTab == .evidence{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EvidenceCell", for: indexPath) as! EvidenceCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommunicationCell", for: indexPath) as! CommunicationCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return selectedTab == .evidence ? 262.0 : 100
    }
}
