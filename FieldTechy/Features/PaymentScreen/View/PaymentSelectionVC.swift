//
//  PaymentSelectionVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 03/09/26.
//

import UIKit

enum paymentSelectionCellType{
    case mode
    case coupon
    case costBreakDown
}

class PaymentSelectionVC: UIViewController {

    @IBOutlet weak var paymentTableView: UITableView!
    @IBOutlet weak var bottomBarView: UIView!
    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var selectedPaymentMode: PaymentMode?
    var cellTypes: [paymentSelectionCellType] = [.mode, .coupon, .costBreakDown]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        cancelBtn.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        cancelBtn.layer.borderWidth = 1
        payBtn.isEnabled = true
    }
    
    func registerCell(){
        Singleton.shared.register(in: paymentTableView, nameOfAllCells: ["PaymentSelectionCell", "AddCouponCell", "CostBreakdownCell"])
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
   @IBAction func queryAction(_ sender: Any) {
            let vc = Singleton.shared.storyBoard(storyboard: "RaiseDispute", identifier: "RaiseDisputeVC")
            self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func onTapPay(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "PostSuccess", identifier: "PostSuccessVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PaymentSelectionVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellTypes[indexPath.row]{
        case .mode:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentSelectionCell", for: indexPath) as! PaymentSelectionCell
            cell.selectedPaymentMode = { [weak self] mode in
                self?.paymentTableView.reloadData()
                self?.selectedPaymentMode = mode
                self?.bottomBarView.isHidden = false
            }
            return cell
            
        case .coupon:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCouponCell", for: indexPath) as! AddCouponCell
            return cell
            
        case .costBreakDown:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CostBreakdownCell", for: indexPath) as! CostBreakdownCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellTypes[indexPath.row]{
        case .mode:
            if let selectedPaymentMode = selectedPaymentMode, selectedPaymentMode == .card{
                return 595
            }else{
                return 289
            }
        case .coupon: return 125
        case .costBreakDown: return 261
        }
    }
}
