//
//  PaymentModeVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 15/09/26.
//

import UIKit

class PaymentModeVC: UIViewController {

    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var addCardView: UIView!
    @IBOutlet weak var addCardTitleLabel: UILabel!
    @IBOutlet weak var addCardAmtLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
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
    @IBOutlet weak var paypalView: UIView!
    @IBOutlet weak var paypalRadioButton: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    
    var fromScreen: String?
    var addedAmt: String?
    var paymentViews: [UIView] {
        [addCardView, contentView, cardView, paypalView]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        addCardAmtLabel.text = addedAmt
        if fromScreen == "Withdraw"{
            headerTitleLabel.text = "Withdraw Money"
            addCardTitleLabel.text = "Withdrawing"
        }else{
            headerTitleLabel.text = "Top Up Wallet"
            addCardTitleLabel.text = "Adding"
        }
        
        continueBtn.isHidden = true
        cardDetailInnerViewHeight.constant = 54
        paymentViews.forEach{
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1.5
            $0.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            $0.layer.masksToBounds = true
        }
        cardDetailInnerStackView.isHidden = true
    }
    
    @IBAction func onTapCardRadioBtn(_ sender: UIButton) {
        updatePaymentMode(.card)
    }
    
    @IBAction func onTapPaypalRadioBtn(_ sender: UIButton) {
        updatePaymentMode(.paypal)
    }

    private func updatePaymentMode(_ mode: PaymentMode) {
        
        continueBtn.isHidden = false
        
        // Update radio buttons
        let radioButtons: [(UIButton, PaymentMode)] = [
            (cardRadioButton, .card),
            (paypalRadioButton, .paypal)
        ]
        
        radioButtons.forEach { button, buttonMode in
            let imageName = buttonMode == mode ? "Radio-Select" : "Radio-Unselect"
            button.setImage(UIImage(named: imageName), for: .normal)
        }
        
        switch mode {
        case .card:
            cardView.layer.borderColor = AppTheme.primaryButtonBGColor.cgColor
            cardView.layer.borderWidth = 1.5
            
            paypalView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            paypalView.layer.borderWidth = 1.5
            
            cardDetailInnerViewHeight.constant = 374
            cardDetailInnerStackView.isHidden = false
            
        case .paypal:
            cardView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            cardView.layer.borderWidth = 1.5
            
            paypalView.layer.borderColor = AppTheme.primaryButtonBGColor.cgColor
            paypalView.layer.borderWidth = 1.5
            
            cardDetailInnerViewHeight.constant = 54
            cardDetailInnerStackView.isHidden = true
        default :
            break
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func queryAction(_ sender: Any) {
            let vc = Singleton.shared.storyBoard(storyboard: "RaiseDispute", identifier: "RaiseDisputeVC")
            self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func continueAction(_ sender: UIButton){
        let vc = Singleton.shared.storyBoard(storyboard: "WalletSuccess", identifier: "WalletSuccessVC") as! WalletSuccessVC
        vc.fromScreen = fromScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
