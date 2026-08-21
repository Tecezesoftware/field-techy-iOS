//
//  OTPSingleTextField.swift
//  FieldTechy
//
//  Created by Kowsalya on 14/08/26.
//

import Foundation
import UIKit

// MARK: - Delegate
protocol OTPSingleTextFieldDelegate: AnyObject {
    func otpFieldDidChange(_ field: OTPSingleTextField)
    func otpFieldDidDelete(_ field: OTPSingleTextField)
}

class OTPSingleTextField: UITextField {

    // MARK: - Delegate
    weak var otpDelegate: OTPSingleTextFieldDelegate?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Setup
    private func setupUI() {
        textAlignment       = .center
        font                = AppFonts.SemiBold(size: 24)
        textColor           = AppTheme.primaryTextColor
        keyboardType        = .numberPad
        textContentType     = .oneTimeCode  // ✅ iOS auto-fill OTP
        backgroundColor     = AppTheme.fieldBGColor
        layer.cornerRadius  = 12
        layer.borderWidth   = 1.5
        layer.borderColor   = AppTheme.borderColorOfViews.cgColor
        tintColor           = .clear // hide cursor
        delegate            = self
        addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }

    // MARK: - States
    func setFilledState() {
        backgroundColor    = AppTheme.fieldBGColor
        layer.borderWidth  = 1.5
        layer.borderColor   = AppTheme.borderColorOfViews.cgColor
        textColor           = AppTheme.primaryTextColor
    }

    func setFocusedState() {
        backgroundColor    = AppTheme.fieldBGColor
        layer.borderWidth  = 1.5
        layer.borderColor  = AppTheme.neutralDark800.cgColor
    }

    func setErrorState() {
        backgroundColor    = AppTheme.error100
        layer.borderWidth  = 1.5
        layer.borderColor  = AppTheme.error800.cgColor
    }

    func resetState() {
        backgroundColor    = AppTheme.fieldBGColor
        layer.borderWidth  = 1.5
        textColor          = AppTheme.primaryTextColor
    }

    // MARK: - Limit to 1 character
    @objc private func textChanged() {
        guard let text = self.text, text.count > 1 else { return }
        self.text = String(text.prefix(1))
    }

    // MARK: - Delete backward
    override func deleteBackward() {
        let isEmpty = text?.isEmpty ?? true
        super.deleteBackward()
        if isEmpty {
            otpDelegate?.otpFieldDidDelete(self)
        }
    }

    // MARK: - Disable selection menu
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        false // disables copy/paste/cut on OTP fields
    }
}

// MARK: - UITextFieldDelegate
extension OTPSingleTextField: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        setFocusedState()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            setFilledState()
        } else {
            resetState()
        }
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        // Only allow numbers
        let allowedChars = CharacterSet.decimalDigits
        let charSet      = CharacterSet(charactersIn: string)
        guard allowedChars.isSuperset(of: charSet) else { return false }

        // Limit to 1 character
        let currentText   = textField.text ?? ""
        let updatedLength = currentText.count + string.count - range.length
        if updatedLength > 1 { return false }

        if !string.isEmpty {
            textField.text = string
            otpDelegate?.otpFieldDidChange(self as! OTPSingleTextField)
            return false
        }
        return true
    }
}
