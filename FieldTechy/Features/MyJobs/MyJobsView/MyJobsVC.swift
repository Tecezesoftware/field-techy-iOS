//
//  MyJobsVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 03/09/26.
//

import UIKit

class MyJobsVC: BaseViewController {
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var postMyJobsButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var previousScreen: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomNavigation(selectedItem: .jobs)
        configureUI()
    }
    
    func configureUI(){
        if UserDefaultsManager.shared.getIsClient{
            headerTitleLabel.text = "My Jobs"
            filterButton.isHidden = false
            postMyJobsButton.isHidden = false
        }else{
            headerTitleLabel.text = previousScreen
            postMyJobsButton.isHidden = true
             if previousScreen == "Wiselist Jobs"{
                filterButton.isHidden = true
            }
        }
    }
    
    @IBAction func onTapPostJob(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "PostJobs", identifier: "PostJobsVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onTapSearch(_ sender: Any) {
        
    }
    
    @IBAction func onTapFilter(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "Filter", identifier: "FilterVC")
        self.navigationController?.present(vc, animated: true)
    }
}

extension MyJobsVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postedJobCell", for: indexPath) as! postedJobCell
        if previousScreen == "Recommended Jobs"{
            cell.saveButton.isHidden = false
        }else{
            cell.saveButton.isHidden = true
        }
        
        if indexPath.row == 1{
            cell.jobtypeLabel.text = "Full Time"
        }else if indexPath.row == 2{
            cell.jobtypeLabel.text = "Scheduled"
        }else{
            cell.jobtypeLabel.text = "Dispatch"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if UserDefaultsManager.shared.getIsClient{
            let vc = Singleton.shared.storyBoard(storyboard: "viewMyJobs", identifier: "viewMyJobsVC") as! viewMyJobsVC
            if indexPath.row == 1{
                vc.jobType = .fulltime
            }else if indexPath.row == 2{
                vc.jobType = .scheduled
            }else{
                vc.jobType = .dispatch
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = Singleton.shared.storyBoard(storyboard: "EngineerViewMyJobs", identifier: "EngineerViewMyJobsVC") as! EngineerViewMyJobsVC
            if indexPath.row == 1{
                vc.jobType = .fulltime
            }else if indexPath.row == 2{
                vc.jobType = .scheduled
            }else{
                vc.jobType = .dispatch
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

class postedJobCell: UITableViewCell{
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var jobId: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var jobLocation: UILabel!
    @IBOutlet weak var jobMode: UILabel!
    @IBOutlet weak var jobstatusBGView: UIView!
    @IBOutlet weak var jobstatusLabel: UILabel!
    @IBOutlet weak var jobtypeLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
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
