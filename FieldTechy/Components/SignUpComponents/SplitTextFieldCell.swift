//
//  SplitTextFieldCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 18/08/26.
//

import UIKit

class SplitTextFieldCell: UITableViewCell {

    @IBOutlet weak var fieldGroupView1: UIView!
    @IBOutlet weak var field1TitleLabel: UILabel!
    @IBOutlet weak var field1TextField: UITextField!
    @IBOutlet weak var fieldGroupView2: UIView!
    @IBOutlet weak var field2TitleLabel: UILabel!
    @IBOutlet weak var field2TextField: UITextField!
    @IBOutlet weak var field2DropDownButton: UIButton!
   
    //MARK: - Properties
    var onValueSelected: ((Int, String) -> Void)?
    var isExpaned: ((Bool) -> ())?
    var engineerFormItem:EngineerFormItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureUI() {
        field1TitleLabel.attributedText = requiredFieldTitleStyle(title: engineerFormItem?.title ?? "")
        field1TextField.placeholder = engineerFormItem?.placeholder ?? ""
        
        field2TitleLabel.attributedText = requiredFieldTitleStyle(title: engineerFormItem?.titleSplitField ?? "")
        field2TextField.placeholder = engineerFormItem?.placeholderSplitField ?? ""
        field2DropDownButton.isHidden = false
        
    }
    
    func requiredFieldTitleStyle(title:String) -> NSMutableAttributedString{
        let attr = NSMutableAttributedString(string: title,
                                             attributes: [.foregroundColor: AppTheme.primaryTextColor, .font: AppFonts.Regular(size: 12.0)])
        
        attr.append(NSAttributedString(
            string: " *",
            attributes: [.foregroundColor: UIColor.red, .font: AppFonts.Regular(size: 12.0)]
        ))
        return attr
    }
    
    @IBAction func didTapOnDropDown(_ sender: UIButton) {
        sender.isSelected.toggle()
        self.isExpaned?(sender.isSelected)
    }
}
