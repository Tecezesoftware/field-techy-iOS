//
//  viewMyJobsVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 07/09/26.
//

import UIKit

class viewMyJobsVC: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    
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
    
    @IBOutlet weak var tabScrollView: UIScrollView!
    @IBOutlet weak var tabInfoStackView: UIStackView!
    @IBOutlet weak var taskInfoTabButton: UIButton!
    @IBOutlet weak var locationTabButton: UIButton!
    @IBOutlet weak var signOffSheetTabButton: UIButton!
    @IBOutlet weak var ratingTabButton: UIButton!
    @IBOutlet weak var paymentRecpTabButton: UIButton!
    @IBOutlet weak var engineerTimelineTabButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    private var communicationButtons:[UIButton] {
        [videoButton,
         callButton,
         chatButton]
    }
    
    private var tabButtons: [UIButton]{
        [taskInfoTabButton,
         locationTabButton,
         signOffSheetTabButton,
         ratingTabButton,
         paymentRecpTabButton,
         engineerTimelineTabButton]
    }
    
    private let taskInfoView = TaskInfomationView.loadFromXIB()
    private let locationView = LocationView.loadFromXIB()
    private let signOffView = SignOffSheetView.loadFromXIB()
    private let timesheetView = TimeSheetView.loadFromXIB()
    private let ratingView = RatingView.loadFromXIB()
    private let paymentReceiptView = PaymentReceiptView.loadFromXIB()
    private let engineerTimelineView = EngineerTimelineView.loadFromXIB()
    private let otherRecieptView = OtherRecieptView.loadFromXIB()
    
    private var currentContentView: UIView?
    var jobType: jobTypes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = true
        
        taskInfoTabButton.isSelected = true
        showTabContent(taskInfoView)
        
//        taskInfoView?.rejectButtonOnTap =  {
//            PopupManager.shared.showRejectRemarks(title: "Reject Engineer", buttonTitle: " Reject engineer", buttonImage: UIImage(named: "CrossIcon"), in: self) { test in
//                print("Dismissed")
//            }
//        }
        
        if jobType == .dispatch {
            
            jobTypeLabel.text = "Dispatch"
            
            taskInfoTabButton.isHidden = false
            locationTabButton.isHidden = false
            signOffSheetTabButton.isHidden = false
            ratingTabButton.isHidden = false
            paymentRecpTabButton.isHidden = false
            engineerTimelineTabButton.isHidden = false
            
            signOffSheetTabButton.setTitle("Sign Off Sheet", for: .normal)
            
            taskInfoView?.jobPaymentStackView.isHidden = true
            taskInfoView?.SMEHeaderLabel.text = "SME Details"
            taskInfoView?.toolRequiredView.isHidden = false
            taskInfoView?.toolsOuterView.isHidden = false
            
        }else if jobType == .fulltime {
            
            jobTypeLabel.text = "Full Time"
            
            taskInfoTabButton.isHidden = false
            locationTabButton.isHidden = false
            signOffSheetTabButton.isHidden = false
            ratingTabButton.isHidden = true
            paymentRecpTabButton.isHidden = false
            engineerTimelineTabButton.isHidden = true
            
            signOffSheetTabButton.setTitle("Timesheet", for: .normal)
            
            taskInfoView?.jobPaymentStackView.isHidden = false
            taskInfoView?.SMEHeaderLabel.text = "Reporting Manager Details"
            taskInfoView?.toolRequiredView.isHidden = true
            taskInfoView?.toolsOuterView.isHidden = true
            
        }else if jobType == .scheduled{
            
            jobTypeLabel.text = "Scheduled"
            
            taskInfoTabButton.isHidden = false
            locationTabButton.isHidden = false
            signOffSheetTabButton.isHidden = false
            ratingTabButton.isHidden = true
            paymentRecpTabButton.isHidden = false
            engineerTimelineTabButton.isHidden = true
            
            signOffSheetTabButton.setTitle("Timesheet", for: .normal)
            
            taskInfoView?.jobPaymentStackView.isHidden = false
            taskInfoView?.SMEHeaderLabel.text = "Reporting Manager Details"
            taskInfoView?.toolRequiredView.isHidden = true
            taskInfoView?.toolsOuterView.isHidden = true
        }
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
        
        updateButtonStyle()
    }
    
    private func showTabContent(_ view: UIView?) {
        
        guard let view = view else { return }
        
        // Remove only the currently displayed tab view
        currentContentView?.removeFromSuperview()
        
        // Add new tab view
        contentView.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        currentContentView = view
        scrollView.setContentOffset(.zero, animated: false)
    }
    
    private func selectTab(_ selectedButton: UIButton) {
        tabButtons.forEach { button in
            button.isSelected = button == selectedButton
        }
        updateButtonStyle()
    }
    
    private func updateButtonStyle() {
        
        tabButtons.forEach { button in
            button.layer.cornerRadius = button.frame.height / 2
            if button.isSelected {
                
                button.backgroundColor = AppTheme.primaryButtonBGColor
                button.setTitleColor(
                    AppTheme.primaryButtonLabelColor,
                    for: .normal
                )
                button.layer.borderWidth = 0
                
            } else {
                
                button.backgroundColor = .clear
                button.setTitleColor(
                    AppTheme.primaryTextColor,
                    for: .normal
                )
                button.layer.borderWidth = 1.5
                button.layer.borderColor =
                    AppTheme.borderColorOfViews.cgColor
            }
        }
    }
    
    @IBAction func taskInfoTabAction(_ sender: UIButton){
        selectTab(sender)
        showTabContent(taskInfoView)
        taskInfoView?.rejectButtonOnTap = {
            PopupManager.shared.showRejectRemarks(title: "Reject Engineer", buttonTitle: " Reject engineer", buttonImage: UIImage(named: "CrossIcon"), in: self) { test in
                print("Dismissed")
            }
        }
    }
    
    @IBAction func locationTabAction(_ sender: UIButton){
        selectTab(sender)
        showTabContent(locationView)
    }
    
    @IBAction func signoffTabAction(_ sender: UIButton){
        selectTab(sender)
        if jobType == .dispatch {
            showTabContent(signOffView)
        }else{
            showTabContent(timesheetView)
        }
    }
    
    @IBAction func ratingTabAction(_ sender: UIButton){
        selectTab(sender)
        showTabContent(ratingView)
    }
    
    @IBAction func paymentReciptTabAction(_ sender: UIButton){
        selectTab(sender)
        if jobType == .dispatch {
            showTabContent(paymentReceiptView)
//            paymentReceiptView?.viewreciept = {[weak self] in
//                let vc = Singleton.shared.storyBoard(storyboard: "InVoiceReceipt", identifier: "InVoiceReceiptVC")
//                self?.navigationController?.pushViewController(vc, animated: true)
//            }
        }else{
            showTabContent(otherRecieptView)
        }
    }
    
    @IBAction func engineerTimelineTabAction(_ sender: UIButton){
        selectTab(sender)
        showTabContent(engineerTimelineView)
    }
    
    @IBAction func backAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func queryAction(_ sender: Any) {
            let vc = Singleton.shared.storyBoard(storyboard: "RaiseDispute", identifier: "RaiseDisputeVC")
            self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func ViewProfileAction(_ sender: UIButton){
        let vc = Singleton.shared.storyBoard(storyboard: "EngineerProfile", identifier: "EngineerProfileVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
