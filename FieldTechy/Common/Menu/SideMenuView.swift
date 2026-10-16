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
    case recommenedJobs
    case myJobs
    case wallet
    case wiselist
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
    @IBOutlet weak var recommendedJobsView: UIView!
    @IBOutlet weak var wiseListView: UIView!
    @IBOutlet weak var bottomAnchorLayout: NSLayoutConstraint!
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
    
    @IBAction func recommendedJobsAction(_ sender: UIButton) {
        onMenuSelection?(.recommenedJobs)
    }

    @IBAction func myJobsAction(_ sender: UIButton) {
        onMenuSelection?(.myJobs)
    }

    @IBAction func walletAction(_ sender: UIButton) {
        onMenuSelection?(.wallet)
    }
    
    @IBAction func wiselistAction(_ sender: UIButton) {
        onMenuSelection?(.wiselist)
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
