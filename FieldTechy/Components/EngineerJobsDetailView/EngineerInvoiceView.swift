//
//  EngineerInvoiceView.swift
//  FieldTechy
//
//  Created by Kowsalya on 01/10/26.
//

import UIKit

class EngineerInvoiceView: UIView {

    @IBOutlet weak var totalAmtLabel: UILabel!
    @IBOutlet weak var platformFeeLabel: UILabel!
    @IBOutlet weak var payableAmtLabel: UILabel!
    @IBOutlet weak var expPaymentLabel: UILabel!
    @IBOutlet weak var paymentStatusLabel: UILabel!
    @IBOutlet weak var paymentStatusStackView: UIStackView!
    @IBOutlet weak var paymentReqStackView: UIStackView!
    @IBOutlet weak var paymentReqField: UITextField!
    @IBOutlet weak var workCompleteOnStackView: UIStackView!
    @IBOutlet weak var workCompleteOnField: UITextField!
    @IBOutlet weak var summaryStackView: UIStackView!
    @IBOutlet weak var summaryField: UITextField!
    @IBOutlet weak var receiptView: UIView!
    @IBOutlet weak var sendPaymentButton: UIButton!
    
    private var fields: [UITextField]{
        [
            paymentReqField,
            workCompleteOnField,
            summaryField
        ]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for field in fields {
            field.layer.cornerRadius = 10
            field.layer.borderWidth = 1.5
            field.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            field.layer.masksToBounds = true
        }
        receiptView.layer.cornerRadius = 10
        receiptView.layer.borderWidth = 1.5
        receiptView.layer.borderColor = AppTheme.brandPrimaryTint.cgColor
    }
    
    func configureUI(jobMode: jobTypes){
        if jobMode == .dispatch{
            paymentStatusStackView.isHidden = false
            paymentReqStackView.isHidden = true
            workCompleteOnStackView.isHidden = true
            summaryStackView.isHidden = true
            sendPaymentButton.isHidden = true
        }else{
            paymentStatusStackView.isHidden = true
            paymentReqStackView.isHidden = false
            workCompleteOnStackView.isHidden = false
            summaryStackView.isHidden = false
            sendPaymentButton.isHidden = false
        }
    }
    
    @IBAction func paymentAction(_ sender: Any) {
    
    }
    
    @IBAction func calendarAction(_ sender: Any) {
    
    }
    
    @IBAction func sendPaymentReqAction(_ sender: Any) {
    
    }
    
}
