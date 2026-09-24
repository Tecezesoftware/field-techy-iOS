//
//  CheckListCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 31/08/26.
//

import UIKit

class CheckListCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var taskStackView: UIStackView!
    @IBOutlet weak var taskFieldView: UITextField!
    
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
    
    @IBAction func AddTask(_ sender: Any) {
        taskStackView.addArrangedSubview(taskFieldView)
    }
}
