//
//  WalletCardViewCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 16/09/26.
//

import UIKit

class WalletCardViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var defaultView: UIView!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var menuOptionView: UIView!
    @IBOutlet weak var expireDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        view.layer.borderWidth = 1
        view.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        
        menuButton.layer.cornerRadius = 10
        menuButton.layer.borderWidth = 1
        menuButton.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        
        menuOptionView.layer.cornerRadius = 10
        menuOptionView.layer.shadowColor = AppTheme.primaryTextColor.cgColor
        menuOptionView.layer.shadowOpacity = 0.15
        menuOptionView.layer.shadowOffset = CGSize(width: 0, height: 2)
        menuOptionView.layer.shadowRadius = 10
        menuOptionView.layer.masksToBounds = false
    }
    
    @IBAction func showMenu(_ sender: UIButton) {
        sender.isSelected.toggle()
        menuOptionView.isHidden = !sender.isSelected
    }
}
