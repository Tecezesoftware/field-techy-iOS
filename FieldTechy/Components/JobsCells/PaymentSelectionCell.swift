//
//  PaymentSelectionCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 03/09/26.
//

enum PaymentMode {
    case card
    case wallet
    case paypal
}

import UIKit

class PaymentSelectionCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardOuterStackView: UIStackView!
    @IBOutlet weak var cardRadioButton: UIButton!
    @IBOutlet weak var cardDetailInnerStackView: UIView!
    @IBOutlet weak var cardDetailInnerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var cardNumberStackView: UIStackView!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardNameStackView: UIStackView!
    @IBOutlet weak var cardNameTextField: UITextField!
    @IBOutlet weak var expiryDateStackView: UIStackView!
    @IBOutlet weak var expiryDateTextField: UITextField!
    @IBOutlet weak var cvvStackView: UIStackView!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var walletView: UIView!
    @IBOutlet weak var walletRadioButton: UIButton!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var paypalView: UIView!
    @IBOutlet weak var paypalRadioButton: UIButton!
    
    var selectedPaymentMode :((PaymentMode)->())?
    
    var paymentViews: [UIView] {
        [view, cardView, walletView, paypalView]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardDetailInnerViewHeight.constant = 54
        paymentViews.forEach{
            $0.layer.cornerRadius = 5
            $0.layer.borderWidth = 1.5
            $0.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            $0.layer.masksToBounds = true
        }
        cardDetailInnerStackView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onTapCardRadioBtn(_ sender: UIButton) {
        updatePaymentMode(.card)
    }
    
    @IBAction func onTapWalletRadioBtn(_ sender: UIButton) {
        updatePaymentMode(.wallet)
    }
    
    @IBAction func onTapPaypalRadioBtn(_ sender: UIButton) {
        updatePaymentMode(.paypal)
    }
    
    private func updatePaymentMode(_ mode: PaymentMode) {
        // Update radio buttons
        let radioButtons: [(UIButton, PaymentMode)] = [
            (cardRadioButton, .card),
            (walletRadioButton, .wallet),
            (paypalRadioButton, .paypal)
        ]
        
        radioButtons.forEach { button, buttonMode in
            let imageName = buttonMode == mode ? "Radio-Select" : "Radio-Unselect"
            button.setImage(UIImage(named: imageName), for: .normal)
        }
        
        switch mode {
        case .card:
            cardView.layer.borderColor = AppTheme.primaryButtonTextColor.cgColor
            cardView.layer.borderWidth = 1.5
            
            walletView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            walletView.layer.borderWidth = 1.5
            
            paypalView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            paypalView.layer.borderWidth = 1.5
            
            cardDetailInnerViewHeight.constant = 374
            cardDetailInnerStackView.isHidden = false
            selectedPaymentMode?(.card)
            
        case .wallet:
            cardView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            cardView.layer.borderWidth = 1.5
            
            walletView.layer.borderColor = AppTheme.primaryButtonTextColor.cgColor
            walletView.layer.borderWidth = 1.5
            
            paypalView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            paypalView.layer.borderWidth = 1.5
            
            cardDetailInnerViewHeight.constant = 54
            cardDetailInnerStackView.isHidden = true
            selectedPaymentMode?(.wallet)
            
        case .paypal:
            cardView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            cardView.layer.borderWidth = 1.5
            
            walletView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            walletView.layer.borderWidth = 1.5
            
            paypalView.layer.borderColor = AppTheme.primaryButtonTextColor.cgColor
            paypalView.layer.borderWidth = 1.5
            
            cardDetailInnerViewHeight.constant = 54
            cardDetailInnerStackView.isHidden = true
            selectedPaymentMode?(.paypal)
        }
    }
    
    @IBAction func expiryDatePicker(_ sender: Any) {
    }
}
