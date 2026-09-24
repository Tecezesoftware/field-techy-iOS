//
//  ToggleCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 19/08/26.
//

import UIKit

// MARK: - Toggle Row Model
struct ToggleRowItem {
    let id: String
    let title: String
    let subtitle: String
    var isOn: Bool
}

class ToggleCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var onsiteToggle: UISwitch!
    @IBOutlet weak var remoteJobsToggle: UISwitch!
    @IBOutlet weak var willingToTravelToggle: UISwitch!
    @IBOutlet weak var dispatchToggle: UISwitch!
    @IBOutlet weak var fullTimeToggle: UISwitch!
    @IBOutlet weak var pushNotificationToggle: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func toggleAction(_ sender: UISwitch) {
        print("Toggle Tag: \(sender.tag)")
    }
}
