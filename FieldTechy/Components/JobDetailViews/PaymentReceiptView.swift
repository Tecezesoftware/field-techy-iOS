//
//  PaymentReceiptView.swift
//  FieldTechy
//
//  Created by Kowsalya on 08/09/26.
//

import UIKit

class PaymentReceiptView: UIView {

    @IBOutlet weak var jobIdLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var paymentDateLabel: UILabel!
    @IBOutlet weak var engineerNameLabel: UILabel!
    @IBOutlet weak var totalAmtLabel: UILabel!
    @IBOutlet weak var fileCountLabel: UILabel!
    @IBOutlet weak var fileStackView: UIStackView!
    @IBOutlet weak var fileContainerView: UIView!
    @IBOutlet weak var fileIconImageView: UIImageView!
    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var fileSizeLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fileContainerView.layer.borderWidth = 1
        fileContainerView.layer.borderColor = AppTheme.primaryButtonBGColor.cgColor
    }
}

extension PaymentReceiptView {
    static func loadFromXIB() -> PaymentReceiptView? {
        let nib = UINib(
            nibName: "PaymentReceiptView",
            bundle: nil
        )

        return nib.instantiate(
            withOwner: nil,
            options: nil
        ).first as? PaymentReceiptView
    }
}
