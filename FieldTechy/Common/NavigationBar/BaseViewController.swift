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
    }
    
    private func showSideMenu() {
        
        guard let menu = SideMenuView.loadFromXIB() else {
            return
        }
        menu.frame = view.bounds
        menu.onClose = { [weak menu] in
            menu?.removeFromSuperview()
        }
        menu.onMenuSelection = { [weak self, weak menu] item in
            menu?.removeFromSuperview()
            self?.handleMenuSelection(item)
        }
        view.addSubview(menu)
    }
    
    private func handleMenuSelection(_ item: SideMenuItem) {
        
        guard let menu = SideMenuView.loadFromXIB() else {
            return
        }
        switch item {
            
        case .dashboard:
            if fromScreen == .dashboard{
                    menu.removeFromSuperview()
            }else{
                let vc = Singleton.shared.storyBoard(storyboard: "ClientDashboard", identifier: "ClientDashboardVC")
                self.navigationController?.pushViewController(vc, animated: false)
            }
            
        case .myJobs:
            if fromScreen == .jobs{
                    menu.removeFromSuperview()
            }else{
                let vc = Singleton.shared.storyBoard(storyboard: "MyJobs", identifier: "MyJobsVC")
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
            print("Dispute")
            
        case .settings:
            print("Settings")
            
        case .aiChat:
            print("AI Chat")
            //                openAIChat()
            
        case .logout:
            showLogoutConfirmation()
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
                    let vc = Singleton.shared.storyBoard(storyboard: "ClientDashboard", identifier: "ClientDashboardVC")
                    self.navigationController?.pushViewController(vc, animated: false)
                }

            case .jobs:
                if selectedItem != .jobs{
                    let vc = Singleton.shared.storyBoard(storyboard: "MyJobs", identifier: "MyJobsVC")
                    self.navigationController?.pushViewController(vc, animated: false)
                }

            case .wallet:
                if selectedItem != .wallet{
                    let vc = Singleton.shared.storyBoard(storyboard: "Wallet", identifier: "WalletVC")
                    self.navigationController?.pushViewController(vc, animated: false)
                }

            case .dispute:
                print("Dispute")
            }
        }
    }
}
