//
//  SignOffSheetView.swift
//  FieldTechy
//
//  Created by Kowsalya on 08/09/26.
//

import UIKit

class SignOffSheetView: UIView {

    @IBOutlet weak var workCompletionNotesContentLabel: UILabel!
    @IBOutlet weak var remarkContentLabel: UILabel!
    @IBOutlet weak var fileCountLabel: UILabel!
    @IBOutlet weak var fileStackView: UIStackView!
    @IBOutlet weak var fileContainerView: UIView!
    @IBOutlet weak var fileIconImageView: UIImageView!
    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var fileSizeLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var engineerNameLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var unitsDoneLabel: UILabel!
 
    override func layoutSubviews() {
        super.layoutSubviews()
        fileContainerView.layer.cornerRadius = 10
        fileContainerView.layer.borderColor = AppTheme.primaryButtonBGColor.cgColor
        fileContainerView.layer.borderWidth = 1
    }

}

extension SignOffSheetView {
    
    static func loadFromXIB() -> SignOffSheetView? {
        let nib = UINib(
            nibName: "SignOffSheetView",
            bundle: nil
        )

        return nib.instantiate(
            withOwner: nil,
            options: nil
        ).first as? SignOffSheetView
    }
}
