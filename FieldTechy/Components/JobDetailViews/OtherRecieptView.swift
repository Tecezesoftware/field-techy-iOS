//
//  OtherRecieptView.swift
//  FieldTechy
//
//  Created by Kowsalya on 10/09/26.
//

import UIKit

class OtherRecieptView: UIView {

    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var receiptView: UIView!
    @IBOutlet weak var paymentTermLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var taskContainerView: UIView!
    @IBOutlet weak var taskContainerStackView: UIStackView!
    @IBOutlet weak var task1View: UIView!
    @IBOutlet weak var task2View: UIView!
    @IBOutlet weak var task3View: UIView!
    
    private var taskViews: [UIView] {
        [
            task1View,
            task2View,
            task3View
        ]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        receiptView.layer.borderWidth = 1
        receiptView.layer.borderColor = AppTheme.primaryButtonBGColor.cgColor
        for taskView in taskViews{
            taskView.layer.cornerRadius = 10
            taskView.layer.borderWidth = 1
            taskView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        }
    }
}

extension OtherRecieptView {
    static func loadFromXIB() -> OtherRecieptView? {
        let nib = UINib(
            nibName: "OtherRecieptView",
            bundle: nil
        )

        return nib.instantiate(
            withOwner: nil,
            options: nil
        ).first as? OtherRecieptView
    }
}
