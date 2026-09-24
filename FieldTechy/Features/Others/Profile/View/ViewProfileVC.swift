//
//  ViewProfileVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 21/09/26.
//

import UIKit

class ViewProfileVC: UIViewController {

    @IBOutlet weak var profileContainerView: UIView!
    @IBOutlet weak var ProfileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var joinedDateLabel: UILabel!
    
    @IBOutlet weak var personalDataContainerView: UIView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var companyDataContainerView: UIView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyAddressLabel: UILabel!
    @IBOutlet weak var companyLocationLabel: UILabel!
    @IBOutlet weak var companyPostalLabel: UILabel!
    @IBOutlet weak var companyCountryLabel: UILabel!
    
    @IBOutlet weak var LoginDataContainerView: UIView!
    @IBOutlet weak var loginEmailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    private var views: [UIView]{
        [
            profileContainerView,
            personalDataContainerView,
            companyDataContainerView,
            LoginDataContainerView
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in views{
            view.layer.cornerRadius = 10
            view.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            view.layer.borderWidth = 1
        }
    }
    
    @IBAction func editProfile(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "ViewProfile", identifier: "EditProfileVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func back(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func queryAction(_ sender: Any){
        let vc = Singleton.shared.storyBoard(storyboard: "RaiseDispute", identifier: "RaiseDisputeVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
