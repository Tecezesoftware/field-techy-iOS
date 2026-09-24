//
//  SettingVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 23/09/26.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var supportView: UIView!
    
    
    private var views: [UIView]{
        [
            profileView,
            accountView,
            notificationView,
            paymentView,
            languageView,
            dataView,
            supportView
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in views{
            view.layer.cornerRadius = 10
            view.layer.borderWidth = 1
            view.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func queryAction(_ sender: Any){
        let vc = Singleton.shared.storyBoard(storyboard: "RaiseDispute", identifier: "RaiseDisputeVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func naviagteToProfile(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "ViewProfile", identifier: "ViewProfileVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func naviagteToAccount(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "Setting", identifier: "AccountSecurityVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func naviagteToNotification(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "Setting", identifier: "NotificationPermissionVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func naviagteToPayment(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "paymentMethod", identifier: "paymentMethodVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func naviagteToLanguage(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "Setting", identifier: "LanguageRegionVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func naviagteToPrivacy(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "Setting", identifier: "DataPrivacyVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func naviagteToSupport(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "Setting", identifier: "HelpSupportVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
