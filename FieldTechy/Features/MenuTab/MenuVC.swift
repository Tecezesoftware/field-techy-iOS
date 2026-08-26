//
//  MenuVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 25/08/26.
//

import UIKit

class MenuVC: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userCompanyLabel: UILabel!
    @IBOutlet weak var userLoctionLabel: UILabel!
    @IBOutlet weak var userJoinedDateLabel: UILabel!
    
    var fromScreen: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func navigateToRespectivePage(_ sender: UIButton) {
        if sender.tag == 0 {
            let vc = Singleton.shared.storyBoard(storyboard: "ClientDashboard", identifier: "ClientDashboardVC")
            if fromScreen == "Dashboard" { self.navigationController?.popViewController(animated: true) } else { self.navigationController?.pushViewController(vc, animated: true) }
        }
    }
    

    @IBAction func CloseAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
}
