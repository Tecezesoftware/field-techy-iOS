//
//  OnboardingVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 06/08/26.
//

import Foundation
import UIKit

class OnboardingVC: UIViewController {
    @IBOutlet weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStartedButton.layer.cornerRadius = 23.5
    }
    
    @IBAction func NavigateToNextScreen(_ sender: UIButton) {
        let vc = Singleton.shared.storyBoard(storyboard: "RoleSelection", identifier: "RoleSelectionVC")
        navigationController?.pushViewController(vc, animated: true)
    }
}
