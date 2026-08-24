//
//  RoleSelectionVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 06/08/26.
//

import UIKit

class RoleSelectionVC: UIViewController {
    
    @IBOutlet weak var clientView: UIView!
    @IBOutlet weak var engineerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        clientView.layer.cornerRadius = 10
        clientView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        clientView.layer.borderWidth = 1.5
        
        engineerView.layer.cornerRadius = 10
        engineerView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        engineerView.layer.borderWidth = 1.5
    }
    
    @IBAction func NavigateToSignInScreen(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "SignIn", identifier: "SignInVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clientTapped(_ sender: Any) {
        UserDefaultsManager.shared.setIsClient(true)
        let vc = Singleton.shared.storyBoard(storyboard: "SignUp", identifier: "SignUpView")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func engineerTapped(_ sender: Any) {
        UserDefaultsManager.shared.setIsClient(false)
        let vc = Singleton.shared.storyBoard(storyboard: "EngineerSignUpContainer", identifier: "EngineerSignUpContainerVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
