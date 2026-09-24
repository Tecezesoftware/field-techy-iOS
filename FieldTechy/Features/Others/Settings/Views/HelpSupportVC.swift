//
//  HelpSupportVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 23/09/26.
//

import UIKit

class HelpSupportVC: UIViewController {

    @IBOutlet weak var emailSupportView: UIView!
    @IBOutlet weak var callSupportView: UIView!
    @IBOutlet weak var resourceView: UIView!
    @IBOutlet weak var faqView: UIView!
    
    private var views: [UIView]{
        [
            emailSupportView,
            callSupportView,
            resourceView,
            faqView
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in views {
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
}
