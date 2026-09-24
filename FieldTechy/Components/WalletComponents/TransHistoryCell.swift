//
//  TransHistoryCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 15/09/26.
//

import UIKit

class TransHistoryCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var tranStatusLabel: UILabel!
    @IBOutlet weak var cardDetailLabel: UILabel!
    @IBOutlet weak var transDateLabel: UILabel!
    @IBOutlet weak var transAmtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = AppTheme.borderColorOfViews.cgColor
    }
}
