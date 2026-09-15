//
//  WithdrawVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 15/09/26.
//

import UIKit

class WithdrawVC: UIViewController{

    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var balanceStackView: UIStackView!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var minmaxLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var benifitsView: UIView!
    
    var fromScreen: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        amountTextField.keyboardType = .numberPad
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        
        view.addGestureRecognizer(tapGesture)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        amountTextField.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        benifitsView.layer.borderWidth = 1
        benifitsView.layer.borderColor = AppTheme.primaryButtonBGColor.cgColor
    }
    
    func configureUI(){
        if fromScreen == "Withdraw"{
            headerTitleLabel.text = "Withdraw Money"
            balanceStackView.isHidden = false
            subtitleLabel.text = "You are withdrawing"
            benifitsView.isHidden = true
        }else{
            headerTitleLabel.text = "Top Up Wallet"
            balanceStackView.isHidden = true
            subtitleLabel.text = "You are adding"
            benifitsView.isHidden = false
        }
    }
    
    @objc private func dismissKeyboard() {
        if amountTextField.text?.count == 0 {
            amountLabel.text = "$0"
        }
        view.endEditing(true)
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addAmtByBtn(_ sender: UIButton) {
        amountTextField.text = "$\(sender.tag)"
        amountLabel.text = "$\(sender.tag)"
    }
    
    @IBAction func continueAction(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "PaymentMode", identifier: "PaymentModeVC") as! PaymentModeVC
        vc.fromScreen = fromScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func amountChanged(_ sender: UITextField) {

        guard let text = sender.text,
              let amount = Int(text) else {
            return
        }
        amountLabel.text = "$\(amount)"
    }
}
