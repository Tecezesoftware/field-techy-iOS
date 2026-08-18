//
//  BaseStepVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 17/08/26.
//

import UIKit

class BaseStepVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomButtonsView: UIView!
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var continueButtonView: UIView!
    @IBOutlet weak var continueButtonLabel: UILabel!
    @IBOutlet weak var continueButtonImageView: UIImageView!
    
    var sharedModel = EngineerSignUpModel()
    
    // MARK: - Init
    init(model: EngineerSignUpModel) {
        self.sharedModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(model:)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Keyboard
    private func setupKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        tableView.contentInset.bottom = frame.height
    }
    
    @objc private func keyboardWillHide() {
        tableView.contentInset.bottom = 0
    }
    
    deinit { NotificationCenter.default.removeObserver(self) }
    
    @IBAction func backButtonAction(_ sender: Any) {
        (parent as? EngineerSignUpContainerVC)?.goToPreviousStep()
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
        (parent as? EngineerSignUpContainerVC)?.goToNextStep()
    }
}
