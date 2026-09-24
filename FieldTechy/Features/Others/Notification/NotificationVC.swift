//
//  NotificationVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 21/09/26.
//

import UIKit

class NotificationVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func back(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func queryAction(_ sender: Any) {
            let vc = Singleton.shared.storyBoard(storyboard: "RaiseDispute", identifier: "RaiseDisputeVC")
            self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension NotificationVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

class NotificationCell: UITableViewCell{
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var notifiIcon: UIImageView!
    @IBOutlet weak var notifiTitleLabel: UILabel!
    @IBOutlet weak var notifiSubTitleLabel: UILabel!
    @IBOutlet weak var notifiDateTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        containerView.layer.shadowColor = AppTheme.primaryTextColor.cgColor
        containerView.layer.shadowOpacity = 0.15
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 10
        containerView.layer.masksToBounds = false
    }
}
