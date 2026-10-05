//
//  EngineerDashboardVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 28/09/26.
//

import UIKit

class EngineerDashboardVC: BaseViewController {
    
    @IBOutlet weak var cardView: GradientView!
    @IBOutlet weak var withdrawButton: UIButton!
    @IBOutlet weak var totalJobsView: UIView!
    @IBOutlet weak var totalJobIconView: UIView!
    @IBOutlet weak var inProgressJobsView: UIView!
    @IBOutlet weak var inprogressJobIconView: UIView!
    @IBOutlet weak var completedJobsView: UIView!
    @IBOutlet weak var completedJobIconView: UIView!
    @IBOutlet weak var cancelledJobsView: UIView!
    @IBOutlet weak var cancelledJobIconView: UIView!
    @IBOutlet weak var recommendedJobCV: UICollectionView!
    @IBOutlet weak var myJobsTV: UITableView!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    
    private var sideMenu: SideMenuView?
    private var outerview: [UIView]{
        [
            totalJobsView,
            inProgressJobsView,
            completedJobsView,
            cancelledJobsView
        ]
    }
    
    private var roundView: [UIView]{
        [
            totalJobIconView,
            inprogressJobIconView,
            completedJobIconView,
            cancelledJobIconView
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO:- Based on number of jobs receiving from API need to update the height, we were doing this due to tableview was been placed inside the scrollview.
        tableviewHeight.constant = 500
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupBottomNavigation(selectedItem: .dashboard)
        
        cardView.cornerRadius = 15
        withdrawButton.layer.cornerRadius = withdrawButton.frame.height / 2
        withdrawButton.layer.borderColor = AppTheme.primaryButtonLabelColor.cgColor
        withdrawButton.layer.borderWidth = 1.5
        
        for view in outerview{
            view.layer.cornerRadius = 15
            view.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            view.layer.borderWidth = 1.5
        }
        
        for view in roundView{
            view.layer.cornerRadius = view.frame.height / 2
        }
    }
    
    @IBAction func searchAction(_ sender: Any) {
    }
    
    @IBAction func notificationAction(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "Notification", identifier: "NotificationVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func WithdrawAction(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "Withdraw", identifier: "WithdrawVC") as! WithdrawVC
        vc.fromScreen = "Withdraw"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension EngineerDashboardVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "jobsCollectionViewCell", for: indexPath) as! jobsCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 280.0, height: 170.0)
    }
}

extension EngineerDashboardVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
           print("numberOfSections")
           return 1
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("at cell for row ")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyJobCell", for: indexPath) as! MyJobCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

class jobsCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var jobsIdLabel: UILabel!
    @IBOutlet weak var jobsAmountLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var jobLocationLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    private var buttons: [UIButton]{
        [
            acceptButton,
            rejectButton,
            saveButton
        ]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = 15
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        
        for button in buttons {
            button.layer.cornerRadius = 5
        }
        
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = AppTheme.borderColorOfViews.cgColor
    }
    
    @IBAction func acceptAction(_ sender: Any) {
    
    }
    
    @IBAction func ignoreAction(_ sender: Any) {
    
    }
    
    @IBAction func saveAction(_ sender: Any) {
    }
}

class MyJobCell: UITableViewCell{
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var jobId: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var jobLocation: UILabel!
    @IBOutlet weak var jobMode: UILabel!
    @IBOutlet weak var jobstatusBGView: UIView!
    @IBOutlet weak var jobstatusLabel: UILabel!
    @IBOutlet weak var jobtypeLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1.5
        view.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        
        jobstatusBGView.layer.cornerRadius = 5
    }
    
    //TODO: - Need to fetch Data from API and configure data dynamically
    func configureUI(){
        
    }
}
