//
//  BaseViewController.swift
//  FieldTechy
//
//  Created by Kowsalya on 07/09/26.
//

import UIKit

class BaseViewController: UIViewController {
    
    var fromScreen: BottomNavItem?
    private let bottomNavigationView = BottomNavigationView()
  
    @IBAction func menuAction(_ sender: UIButton) {
        showSideMenu()
        bottomNavigationView.isHidden = true
    }
    
    private func showSideMenu() {
        
        let menu : SideMenuView = .loadFromXIB()
        menu.frame = view.bounds
        menu.onClose = { [weak menu] in
            menu?.removeFromSuperview()
            self.bottomNavigationView.isHidden = false
        }
        menu.onMenuSelection = { [weak self, weak menu] item in
            menu?.removeFromSuperview()
            self?.bottomNavigationView.isHidden = false
            self?.handleMenuSelection(item)
        }
        menu.chatBotView.cornerRadius = 15
        
        if UserDefaultsManager.shared.getIsClient{
            menu.bottomAnchorLayout.constant = 102
            menu.recommendedJobsView.isHidden = true
            menu.wiseListView.isHidden = true
        }else{
            menu.bottomAnchorLayout.constant = 36
            menu.recommendedJobsView.isHidden = false
            menu.wiseListView.isHidden = false
        }
        
        view.addSubview(menu)
    }
    
    private func handleMenuSelection(_ item: SideMenuItem) {
        
        let menu : SideMenuView = .loadFromXIB()
        switch item {
        case .profile:
            let vc = Singleton.shared.storyBoard(storyboard: "ViewProfile", identifier: "ViewProfileVC")
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .dashboard:
            if fromScreen == .dashboard{
                    menu.removeFromSuperview()
            }else{
                if UserDefaultsManager.shared.getIsClient{
                    let vc = Singleton.shared.storyBoard(storyboard: "ClientDashboard", identifier: "ClientDashboardVC")
                    self.navigationController?.pushViewController(vc, animated: false)
                }else{
                    let vc = Singleton.shared.storyBoard(storyboard: "EngineerDashboard", identifier: "EngineerDashboardVC")
                    self.navigationController?.pushViewController(vc, animated: false)
                }
            }
            
        case .myJobs:
            if fromScreen == .jobs{
                    menu.removeFromSuperview()
            }else{
                let vc = Singleton.shared.storyBoard(storyboard: "MyJobs", identifier: "MyJobsVC") as! MyJobsVC
                vc.previousScreen = "MyJobs"
                self.navigationController?.pushViewController(vc, animated: false)
            }
            
        case .wallet:
            if fromScreen == .wallet{
                    menu.removeFromSuperview()
            }else{
                let vc = Singleton.shared.storyBoard(storyboard: "Wallet", identifier: "WalletVC")
                self.navigationController?.pushViewController(vc, animated: false)
            }
            
        case .dispute:
            if fromScreen == .dispute{
                    menu.removeFromSuperview()
            }else{
                let vc = Singleton.shared.storyBoard(storyboard: "Dispute", identifier: "DisputeVC")
                self.navigationController?.pushViewController(vc, animated: false)
            }
            
        case .settings:
            let vc = Singleton.shared.storyBoard(storyboard: "Setting", identifier: "SettingVC")
            self.navigationController?.pushViewController(vc, animated: false)
            
        case .aiChat:
            print("AI Chat")
            let vc = Singleton.shared.storyBoard(storyboard: "UnderDevelopmentVC", identifier: "UnderDevelopmentVC") as! UnderDevelopmentVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .logout:
            showLogoutConfirmation()
            
        case .recommenedJobs:
            if fromScreen == .jobs{
                    menu.removeFromSuperview()
            }else{
                let vc = Singleton.shared.storyBoard(storyboard: "MyJobs", identifier: "MyJobsVC") as! MyJobsVC
                vc.previousScreen = "Recommended Jobs"
                self.navigationController?.pushViewController(vc, animated: false)
            }
        case .wiselist:
            if fromScreen == .jobs{
                    menu.removeFromSuperview()
            }else{
                let vc = Singleton.shared.storyBoard(storyboard: "MyJobs", identifier: "MyJobsVC") as! MyJobsVC
                vc.previousScreen = "Wiselist Jobs"
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
    
    private func showLogoutConfirmation() {
        PopupManager.shared.showLogout(in: self) {
            UserDefaultsManager.shared.logout()
            let vc = Singleton.shared.storyBoard(storyboard: "SignIn", identifier: "SignInVC")
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    func setupBottomNavigation(selectedItem: BottomNavItem) {
        bottomNavigationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomNavigationView)
        bottomNavigationView.updateViewConstraints(view: view, bottomNavigationView: bottomNavigationView)
        
        bottomNavigationView.selectedItem = selectedItem
        bottomNavigationView.onItemSelected = { item in

            switch item {
            case .dashboard:
                if selectedItem != .dashboard{
                    if UserDefaultsManager.shared.getIsClient{
                        let vc = Singleton.shared.storyBoard(storyboard: "ClientDashboard", identifier: "ClientDashboardVC")
                        self.navigationController?.pushViewController(vc, animated: false)
                    }else{
                        let vc = Singleton.shared.storyBoard(storyboard: "EngineerDashboard", identifier: "EngineerDashboardVC")
                        self.navigationController?.pushViewController(vc, animated: false)
                    }
                }

            case .jobs:
                if selectedItem != .jobs{
                    let vc = Singleton.shared.storyBoard(storyboard: "MyJobs", identifier: "MyJobsVC") as! MyJobsVC
                    vc.previousScreen = "MyJobs"
                    self.navigationController?.pushViewController(vc, animated: false)
                }

            case .wallet:
                if selectedItem != .wallet{
                    let vc = Singleton.shared.storyBoard(storyboard: "Wallet", identifier: "WalletVC")
                    self.navigationController?.pushViewController(vc, animated: false)
                }

            case .dispute:
                if selectedItem != .dispute{
                    let vc = Singleton.shared.storyBoard(storyboard: "Dispute", identifier: "DisputeVC")
                    self.navigationController?.pushViewController(vc, animated: false)
                }
            }
        }
    }
}
