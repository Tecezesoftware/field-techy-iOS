//
//  AddPaymentMethodVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 17/09/26.
//

import UIKit

class AddPaymentMethodVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var paymentMethodTextField: UITextField!
    @IBOutlet weak var paymentMethodDropDown: UIButton!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardNameTextField: UITextField!
    @IBOutlet weak var expiryDateTextField: UITextField!
    @IBOutlet weak var expiryDateCalButton: UIButton!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var defaultToggle: UISwitch!
    @IBOutlet weak var discardButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var isAddPayment: Bool?
    var isEditPayment: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discardButton.layer.borderWidth = 1
        discardButton.layer.borderColor = AppTheme.borderColorOfViews.cgColor
    }
    
    func configureUI(){
        if isAddPayment == true{
            titleLabel.text = "Add a payment method"
            discardButton.setTitle("  Discard", for: .normal)
            discardButton.setImage(UIImage(named: "CrossBlueIcon"), for: .normal)
            saveButton.isHidden = false
        }else{
            titleLabel.text = "View payment method"
            discardButton.setTitle("  Edit", for: .normal)
            discardButton.setImage(UIImage(named: "EditIcon"), for: .normal)
            saveButton.isHidden = true
            
            paymentMethodTextField.isUserInteractionEnabled = false
            cardNumberTextField.isUserInteractionEnabled = false
            cardNameTextField.isUserInteractionEnabled = false
            expiryDateTextField.isUserInteractionEnabled = false
            cvvTextField.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func save(_ sender: Any) {
        print("Saved Card Data")
        self.dismiss(animated: true)
    }
    
    @IBAction func discard(_ sender: Any) {
        if isEditPayment == true{
            self.dismiss(animated: false)
        }else{
            if isAddPayment == true{
                self.dismiss(animated: false)
            }else{
                isEditPayment = true
                titleLabel.text = "Edit payment method"
                discardButton.setTitle("  Discard", for: .normal)
                discardButton.setImage(UIImage(named: "CrossBlueIcon"), for: .normal)
                saveButton.isHidden = false
                
                paymentMethodTextField.isUserInteractionEnabled = true
                cardNumberTextField.isUserInteractionEnabled = true
                cardNameTextField.isUserInteractionEnabled = true
                expiryDateTextField.isUserInteractionEnabled = true
                cvvTextField.isUserInteractionEnabled = true
            }
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
}
