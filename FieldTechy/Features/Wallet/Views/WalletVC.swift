//
//  WalletVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 14/09/26.
//

import UIKit

class WalletVC: BaseViewController {

    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var updatedStatusLabel: UILabel!
    
    @IBOutlet weak var quickActionView: UIView!
    @IBOutlet weak var addBalanceView: UIView!
    @IBOutlet weak var withdrawView: UIView!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var historyView: UIView!
    
    @IBOutlet weak var historyTableView: UITableView!
    
    private var quickActionViews: [UIView] {
        [
            addBalanceView,
            withdrawView,
            paymentView,
            historyView
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(){
        setupBottomNavigation(selectedItem: .wallet)
        Singleton.shared.register(in: historyTableView, nameOfAllCells: ["TransHistoryCell"])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        quickActionView.layer.cornerRadius = 15
        quickActionView.layer.shadowColor = AppTheme.primaryTextColor.cgColor
        quickActionView.layer.shadowOpacity = 0.15
        quickActionView.layer.shadowOffset = CGSize(width: 0, height: 2)
        quickActionView.layer.shadowRadius = 4
        quickActionView.layer.masksToBounds = false
        
        for view in quickActionViews {
            view.layer.cornerRadius = view.layer.frame.height/2
            view.layer.borderWidth = 1
            view.layer.borderColor = view == addBalanceView ? AppTheme.brandPrimaryTint.cgColor : AppTheme.borderColorOfViews.cgColor
        }
        
    }
    
    @IBAction func onTapFilter(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "Filter", identifier: "FilterVC")
        self.navigationController?.present(vc, animated: true)
    }
    
    @IBAction func navigateToTopupScreen(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "Withdraw", identifier: "WithdrawVC") as! WithdrawVC
        vc.fromScreen = "Topup"
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func navigateToWithdrawScreen(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "Withdraw", identifier: "WithdrawVC") as! WithdrawVC
        vc.fromScreen = "Withdraw"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func navigateToPaymentScreen(_ sender: Any) {
        
    }
    
    @IBAction func navigateToHistoryScreen(_ sender: Any) {
        
    }
}

extension WalletVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransHistoryCell", for: indexPath) as! TransHistoryCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
}
