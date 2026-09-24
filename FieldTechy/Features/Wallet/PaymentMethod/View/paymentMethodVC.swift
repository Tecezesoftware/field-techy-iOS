//
//  paymentMethodVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 16/09/26.
//

import UIKit

class paymentMethodVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    func registerCell(){
        Singleton.shared.register(in: tableView, nameOfAllCells: ["WalletCardViewCell"])
    }
    
    @IBAction func addPayment(_ sender: UIButton){
        let vc = Singleton.shared.storyBoard(storyboard: "AddPaymentMethod", identifier: "AddPaymentMethodVC") as! AddPaymentMethodVC
        vc.isAddPayment = true
        self.navigationController?.present(vc, animated: true)
    }
    
    
    @IBAction func back(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

extension paymentMethodVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletCardViewCell", for: indexPath) as! WalletCardViewCell
        
        cell.viewPayment = {[weak self] in
            let vc = Singleton.shared.storyBoard(storyboard: "AddPaymentMethod", identifier: "AddPaymentMethodVC") as! AddPaymentMethodVC
            vc.isAddPayment = false
            self?.navigationController?.present(vc, animated: true)
        }
        
        cell.deletePayment = {[weak self] in
            guard let self = self else { return }
            PopupManager.shared.showDeleteConfirm(in: self) {
                print("Deleted...")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125.0
    }

}
