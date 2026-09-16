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
    }
    
    func registerCell(){
        Singleton.shared.register(in: tableView, nameOfAllCells: ["WalletCardViewCell"])
    }
}

extension paymentMethodVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletCardViewCell", for: indexPath) as! WalletCardViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125.0
    }

}
