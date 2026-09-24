//
//  PopupManager.swift
//  FieldTechy
//
//  Created by Kowsalya on 26/08/26.
//

import UIKit

final class PopupManager {

    // MARK: - Singleton
    static let shared = PopupManager()
    private init() {}

    // MARK: - Show Popup
    func show(config: PopupConfig, in viewController: UIViewController) {
        let popup = CustomPopupView()
        popup.configure(with: config)
        popup.show(in: viewController.view)
    }

    // MARK: - Preset Popups

    // ✅ Logout Confirmation
    func showLogout(
        in vc: UIViewController,
        buttonImage: UIImage? = nil,
        onNo: (() -> Void)? = nil,
        onYes: (() -> Void)?
    ) {
        let config = PopupConfig(
            type: .confirmation,
            iconType: .logout,
            title: "Log out",
            subtitle: "Are you sure you want to Log out?",
            buttons: [
                PopupButton(title: "No", style: .primary, image: buttonImage, action: onNo),
                PopupButton(title: "Yes",  style: .secondary, image: buttonImage,   action: onYes)
            ]
        )
        show(config: config, in: vc)
    }

    // ❌ Delete Confirmation
    func showDeleteConfirm(
        in vc: UIViewController,
        buttonImage: UIImage? = nil,
        onNo: (() -> Void)? = nil,
        onYes: (() -> Void)?
    ) {
        let config = PopupConfig(
            type: .confirmation,
            iconType: .delete,
            title: "Are you sure you want to delete?",
            subtitle: "",
            buttons: [
                PopupButton(title: "No", style: .primary, image: buttonImage, action: onNo),
                PopupButton(title: "Yes",  style: .secondary, image: buttonImage,   action: onYes)
            ]
        )
        show(config: config, in: vc)
    }
    
    // ❌ Engineer Rejected
    func showEngineerRejected(
        in vc: UIViewController,
        buttonImage: UIImage? = nil,
        onBackToJobs: (() -> Void)?
    ) {
        let config = PopupConfig(
            type: .status,
            iconType: .error,
            title: "Engineer Rejected",
            subtitle: "The engineer has been rejected",
            buttons: [
                PopupButton(title: "Back to Jobs", style: .primary, image: buttonImage, action: onBackToJobs)
            ]
        )
        show(config: config, in: vc)
    }

    // ❌ Rejected
    func showRejected(
        subtitle: String,
        buttonImage: UIImage? = nil,
        in vc: UIViewController,
        onBackToJobs: (() -> Void)?
    ) {
        let config = PopupConfig(
            type: .status,
            iconType: .error,
            title: "Rejected",
            subtitle: subtitle,
            buttons: [
                PopupButton(title: "Back to Jobs", style: .primary, image: buttonImage, action: onBackToJobs)
            ]
        )
        show(config: config, in: vc)
    }

    // ✅ Receipt Downloaded
    func showReceiptDownloaded(
        in vc: UIViewController,
        buttonImage: UIImage? = nil,
        onDone: (() -> Void)?
    ) {
        let config = PopupConfig(
            type: .status,
            iconType: .success,
            title: "Receipt Downloaded",
            subtitle: nil,
            buttons: [
                PopupButton(title: "Done", style: .primary, image: buttonImage, action: onDone)
            ]
        )
        show(config: config, in: vc)
    }

    // ⚠️ Alert
    func showAlert(
        subtitle: String,
        buttonTitle: String = "Ok",
        buttonImage: UIImage? = nil,
        in vc: UIViewController,
        onOk: (() -> Void)?
    ) {
        let config = PopupConfig(
            type: .alert,
            iconType: .warning,
            title: "Alert",
            subtitle: subtitle,
            buttons: [
                PopupButton(title: buttonTitle, style: .primary, image: buttonImage, action: onOk)
            ]
        )
        show(config: config, in: vc)
    }

    // 📝 Remarks — Reject Sign Off Sheet
    func showRejectRemarks(
        title: String,
        buttonTitle: String,
        buttonImage: UIImage? = nil,
        placeholder: String = "Enter Remarks",
        in vc: UIViewController,
        onSubmit: ((String) -> Void)?
    ) {
        let config = PopupConfig(
            type: .remarks(placeholder: placeholder),
            iconType: .none,
            title: title,
            buttons: [
                PopupButton(title: buttonTitle, style: .destructive, image: buttonImage, action: nil)
            ],
            onRemarksSubmit: onSubmit
        )
        show(config: config, in: vc)
    }

    // ❌ Payment Rejected
    func showPaymentRejected(
        in vc: UIViewController,
        buttonImage: UIImage? = nil,
        onBackToJobs: (() -> Void)?
    ) {
        let config = PopupConfig(
            type: .status,
            iconType: .error,
            title: "Payment Rejected",
            subtitle: "The engineer Payment has been rejected",
            buttons: [
                PopupButton(title: "Back to Jobs", style: .primary, image: buttonImage, action: onBackToJobs)
            ]
        )
        show(config: config, in: vc)
    }
}
