//
//  CompleteButtonCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 10/08/26.
//

import UIKit

class CompleteButtonCell: UITableViewCell {
    
    @IBOutlet weak var buttonLabel: UILabel!
    var navigateToRespectiveScreen: (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func submitbuttonAction(_ sender: Any) {
        self.navigateToRespectiveScreen?()
    }
}
