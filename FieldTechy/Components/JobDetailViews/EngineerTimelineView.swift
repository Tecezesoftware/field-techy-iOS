//
//  EngineerTimelineView.swift
//  FieldTechy
//
//  Created by Kowsalya on 08/09/26.
//

import UIKit

class EngineerTimelineView: UIView {

    @IBOutlet weak var inOutTimeView: UIView!
    @IBOutlet weak var inOutLabel: UILabel!
    @IBOutlet weak var totalHrsLabel: UILabel!
    @IBOutlet weak var extraWorkingHrsView: UIView!
    @IBOutlet weak var extradateLabel: UILabel!
    @IBOutlet weak var extraHrsLabel: UILabel!
    @IBOutlet weak var extraRemarksLabel: UILabel!
    @IBOutlet weak var extraCostLabel: UILabel!
    @IBOutlet weak var extraStatusLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        inOutTimeView.layer.cornerRadius = 10
        inOutTimeView.layer.borderWidth = 1
        inOutTimeView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        
        extraWorkingHrsView.layer.cornerRadius = 10
        extraWorkingHrsView.layer.borderWidth = 1
        extraWorkingHrsView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
    }
    
    @IBAction func approve(_ sender: Any) {
        
    }
    
    @IBAction func reject(_ sender: Any) {
        
    }
}

extension EngineerTimelineView {
    static func loadFromXIB() -> EngineerTimelineView? {
        let nib = UINib(
            nibName: "EngineerTimelineView",
            bundle: nil
        )

        return nib.instantiate(
            withOwner: nil,
            options: nil
        ).first as? EngineerTimelineView
    }
}
