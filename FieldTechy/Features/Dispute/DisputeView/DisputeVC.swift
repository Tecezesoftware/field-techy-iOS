//
//  DisputeVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 17/09/26.
//

import UIKit

class DisputeVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomNavigation(selectedItem: .dispute)
    }
    
    @IBAction func onTapRaiseDispute(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "RaiseDispute", identifier: "RaiseDisputeVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onTapSearch(_ sender: Any) {
        
    }
    
    @IBAction func onTapFilter(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "Filter", identifier: "FilterVC")
        self.navigationController?.present(vc, animated: true)
    }
}

extension DisputeVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DisputeIssueCell", for: indexPath) as! DisputeIssueCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Singleton.shared.storyBoard(storyboard: "ViewDispute", identifier: "ViewDisputeVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

class DisputeIssueCell: UITableViewCell{
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var issueId: UILabel!
    @IBOutlet weak var issueTitle: UILabel!
    @IBOutlet weak var issueBy: UILabel!
    @IBOutlet weak var issueReason: UILabel!
    @IBOutlet weak var issuestatusBGView: UIView!
    @IBOutlet weak var issuestatusLabel: UILabel!
    @IBOutlet weak var issueAgainstLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1.5
        view.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        
        issuestatusBGView.layer.cornerRadius = 5
    }
    
    //TODO: - Need to fetch Data from API and configure data dynamically
    func configureUI(){
        
    }
}
