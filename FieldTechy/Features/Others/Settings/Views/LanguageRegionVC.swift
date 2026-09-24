//
//  LanguageRegionVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 23/09/26.
//

import UIKit

class LanguageRegionVC: UIViewController {
    
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var languageField: UITextField!
    @IBOutlet weak var regionField: UITextField!
    
    @IBOutlet weak var timeDateView: UIView!
    @IBOutlet weak var timeZoneField: UITextField!
    @IBOutlet weak var dateFormatField: UITextField!
    @IBOutlet weak var timeFormatField: UITextField!
    
    @IBOutlet weak var currencyView: UIView!
    @IBOutlet weak var currencyField: UITextField!
    @IBOutlet weak var numberFormatField: UITextField!
    
    @IBOutlet weak var discardButton: UIButton!
    
    private var views:[UIView]{
        [
            languageView,
            timeDateView,
            currencyView
        ]
    }
    
    private var fields:[UITextField]{
        [
            languageField,
            regionField,
            timeZoneField,
            dateFormatField,
            timeFormatField,
            currencyField,
            numberFormatField
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in views{
            view.layer.cornerRadius = 10
            view.layer.borderWidth = 1
            view.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        }
        
        for field in fields {
            field.layer.cornerRadius = 10
            field.layer.borderWidth = 1.5
            field.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            field.layer.masksToBounds = true
        }
        discardButton.layer.cornerRadius = discardButton.frame.height / 2
        discardButton.layer.borderWidth = 1
        discardButton.layer.borderColor = AppTheme.borderColorOfViews.cgColor
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func queryAction(_ sender: Any){
        let vc = Singleton.shared.storyBoard(storyboard: "RaiseDispute", identifier: "RaiseDisputeVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
