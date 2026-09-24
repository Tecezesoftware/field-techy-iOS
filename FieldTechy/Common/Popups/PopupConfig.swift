//
//  PopupConfig.swift
//  FieldTechy
//
//  Created by Kowsalya on 26/08/26.
//

import Foundation
import UIKit

// MARK: - Popup Icon Type
enum PopupIconType {
    case success
    case error
    case warning
    case logout
    case delete
    case custom(UIImage, UIColor)
    case none
}

// MARK: - Popup Button Style
struct PopupButton {
    let title: String
    let style: ButtonStyle
    let image: UIImage?
    let action: (() -> Void)?

    enum ButtonStyle {
        case primary    // green filled
        case secondary  // gray filled
        case destructive // red filled
        case outline    // white with border
    }
}

// MARK: - Popup Type
enum PopupType {
    case status                     // icon + title + subtitle + buttons
    case confirmation               // icon + title + subtitle + 2 buttons
    case remarks(placeholder: String) // title + textview + button
    case alert                      // warning + title + subtitle + button
}

// MARK: - Popup Config
struct PopupConfig {
    var type: PopupType             = .status
    var iconType: PopupIconType     = .none
    var title: String               = ""
    var subtitle: String?           = nil
    var buttons: [PopupButton]      = []
    var isDismissable: Bool         = true  
    var onDismiss: (() -> Void)?    = nil
    var onRemarksSubmit: ((String) -> Void)? = nil
}
