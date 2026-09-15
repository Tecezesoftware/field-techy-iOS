//
//  WalletSuccessVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 15/09/26.
//

import UIKit

class WalletSuccessVC: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var fromScreen: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        
        if fromScreen == "Withdraw" {
            titleLabel.text = "Withdrawal Successful"
            subtitleLabel.text = "Your withdrawal has been processed successfully"
        }else{
            titleLabel.text = "Top-Up Successful"
            subtitleLabel.text = "Your wallet has been credited successfully"
        }
    }
    
    @IBAction func onTapOk(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "Wallet", identifier: "WalletVC")
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
