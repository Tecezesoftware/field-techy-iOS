//
//  MyJobsVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 03/09/26.
//

import UIKit

class MyJobsVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomNavigation(selectedItem: .jobs)
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Singleton.shared.storyBoard(storyboard: "viewMyJobs", identifier: "viewMyJobsVC") as! viewMyJobsVC
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

class postedJobCell: UITableViewCell{
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
