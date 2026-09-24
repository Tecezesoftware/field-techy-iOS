//
//  DataPrivacyVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 23/09/26.
//

import UIKit

class DataPrivacyVC: UIViewController {
    
    @IBOutlet weak var analyticsView: UIView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var downloadView: UIView!
    @IBOutlet weak var downloadIconView:UIView!
    @IBOutlet weak var discardButton: UIButton!
    
    private var views: [UIView]{
        [
            analyticsView,
            dataView,
            downloadView,
            discardButton
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
        downloadIconView.layer.cornerRadius = downloadIconView.frame.height / 2
        downloadIconView.layer.borderWidth = 1
        downloadIconView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        
        discardButton.layer.cornerRadius = discardButton.frame.height / 2
        discardButton.layer.borderWidth = 1
        discardButton.layer.borderColor = AppTheme.borderColorOfViews.cgColor
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func queryAction(_ sender: Any){
        let vc = Singleton.shared.storyBoard(storyboard: "RaiseDispute", identifier: "RaiseDisputeVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
