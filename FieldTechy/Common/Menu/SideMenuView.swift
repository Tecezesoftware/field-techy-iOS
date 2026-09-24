//
//  MenuView.swift
//  FieldTechy
//
//  Created by Kowsalya on 03/09/26.
//

import UIKit

enum SideMenuItem {
    case profile
    case dashboard
    case myJobs
    case wallet
    case dispute
    case settings
    case logout
    case aiChat
}

class SideMenuView: UIView {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userCompanyLabel: UILabel!
    @IBOutlet weak var userLoctionLabel: UILabel!
    @IBOutlet weak var userJoinedDateLabel: UILabel!
    @IBOutlet weak var chatBotView: GradientView!
    
    
    var onMenuSelection: ((SideMenuItem) -> Void)?
    var onClose: (() -> Void)?

    @IBAction func closeAction(_ sender: UIButton) {
        onClose?()
    }
    
    @IBAction func navigateToProfile(_ sender: UIButton){
        onMenuSelection?(.profile)
    }

    @IBAction func dashboardAction(_ sender: UIButton) {
        onMenuSelection?(.dashboard)
    }

    @IBAction func myJobsAction(_ sender: UIButton) {
        onMenuSelection?(.myJobs)
    }

    @IBAction func walletAction(_ sender: UIButton) {
        onMenuSelection?(.wallet)
    }

    @IBAction func disputeAction(_ sender: UIButton) {
        onMenuSelection?(.dispute)
    }

    @IBAction func settingsAction(_ sender: UIButton) {
        onMenuSelection?(.settings)
    }

    @IBAction func aiChatAction(_ sender: UIButton) {
        onMenuSelection?(.aiChat)
    }

    @IBAction func logoutAction(_ sender: UIButton) {
        onMenuSelection?(.logout)
    }

}

extension SideMenuView {

    static func loadFromXIB() -> SideMenuView? {
        let nib = UINib(
            nibName: "SideMenuView",
            bundle: nil
        )

        return nib.instantiate(
            withOwner: nil,
            options: nil
        ).first as? SideMenuView
    }
}
