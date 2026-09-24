//
//  AddCouponCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 03/09/26.
//

import UIKit

class AddCouponCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1.5
        view.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        view.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onTapApply(_ sender: Any) {
        print("On Tap Apply ")
    }
}
