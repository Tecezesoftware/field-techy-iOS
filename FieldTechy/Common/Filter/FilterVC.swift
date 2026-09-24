//
//  FilterVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 07/09/26.
//

enum filterCategory{
    case status
    case jobType
    case skillLevel
    case jobMode
}

import UIKit

class FilterVC: UIViewController {
    @IBOutlet weak var clearAllBtnView: UIView!
    @IBOutlet weak var filterTableView: UITableView!
    
    var filterCategories : [filterCategory] = [.status, .jobType, .skillLevel, .jobMode]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAllBtnView.layer.borderWidth = 1
        clearAllBtnView.layer.borderColor = AppTheme.brandPrimaryTint.cgColor
        clearAllBtnView.layer.cornerRadius = clearAllBtnView.frame.height / 2
        Singleton.shared.register(in: filterTableView, nameOfAllCells: ["JobsTextFieldWithDDCell"])
    }
    
    @IBAction func onTapclearAll(_ sender: Any) {
        
    }
    
    @IBAction func onTapClose(_ sender: Any) {
        self.dismiss(animated: false)
    }
}

extension FilterVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch filterCategories[indexPath.row]{
        case .status:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobsTextFieldWithDDCell", for: indexPath) as! JobsTextFieldWithDDCell
            cell.configureUIForFilter(title: "Status")
            return cell
        case .jobType:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobsTextFieldWithDDCell", for: indexPath) as! JobsTextFieldWithDDCell
            cell.configureUIForFilter(title: "Job Type")
            return cell
        case .skillLevel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobsTextFieldWithDDCell", for: indexPath) as! JobsTextFieldWithDDCell
            cell.configureUIForFilter(title: "Skill Level")
            return cell
        case .jobMode:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobsTextFieldWithDDCell", for: indexPath) as! JobsTextFieldWithDDCell
            cell.configureUIForFilter(title: "Job Mode")
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}
