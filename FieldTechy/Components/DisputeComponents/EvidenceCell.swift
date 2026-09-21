//
//  EvidenceCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 18/09/26.
//

import UIKit

class EvidenceCell: UITableViewCell {
    @IBOutlet weak var attachmentView: UIView!
    @IBOutlet weak var attachmentStackView: UIStackView!
    
    @IBOutlet weak var attachmentView1: UIView!
    @IBOutlet weak var attachmentIcon1: UIImageView!
    @IBOutlet weak var attachmentTitleLabel1: UILabel!
    @IBOutlet weak var attachmentSizeLabel1: UILabel!
    
    @IBOutlet weak var attachmentView2: UIView!
    @IBOutlet weak var attachmentIcon2: UIImageView!
    @IBOutlet weak var attachmentTitleLabel2: UILabel!
    @IBOutlet weak var attachmentSizeLabel2: UILabel!
    
    @IBOutlet weak var uploadView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        attachmentView.layer.cornerRadius = 10
        
        attachmentView1.layer.cornerRadius = 10
        attachmentView1.layer.borderWidth = 1
        attachmentView1.layer.borderColor = AppTheme.brandPrimaryTint.cgColor
        
        attachmentView2.layer.cornerRadius = 10
        attachmentView2.layer.borderWidth = 1
        attachmentView2.layer.borderColor = AppTheme.brandPrimaryTint.cgColor
        
        uploadView.layer.cornerRadius = 10
        uploadView.layer.borderWidth = 1
        uploadView.layer.borderColor = AppTheme.neutralLight800.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func uploadAttachment(_ sender: Any) {
        
    }
}
