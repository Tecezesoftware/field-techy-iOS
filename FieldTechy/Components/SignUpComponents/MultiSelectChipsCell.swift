//
//  MultiSelectChipsCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 18/08/26.
//

import UIKit

class MultiSelectChipsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chipsFieldView: UITextField!
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var chipsStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func appendChips(_ chips: [String]) {
        var remainingChipsCount = 0
        for (index, chip) in chips.enumerated() {
            if index > 4 {
                configureChips(chipLabel: chip)
            }else{
                remainingChipsCount += 1
            }
        }
        if remainingChipsCount < 0 {
            configureChips(chipLabel: String(remainingChipsCount))
        }
    }
    
    func configureChips(chipLabel: String) {
        let chip = UIView()
        chip.backgroundColor = AppTheme.neutralLight800
        chip.layer.cornerRadius = chip.layer.frame.height / 2
        
        let label = UILabel()
        label.text = chipLabel
        label.textColor = AppTheme.primaryTextColor
        label.font = AppFonts.Medium(size: 11)
        chip.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: chip.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: chip.centerXAnchor).isActive = true
        
//        chip.bottomAnchor.constraint(equalTo: chipsStackView.bottomAnchor, constant: 0).isActive = true
//        chip.topAnchor.constraint(equalTo: chipsStackView.topAnchor, constant: 0).isActive = true
//        chip.leadingAnchor.constraint(equalTo: chipsStackView.leadingAnchor, constant: 0).isActive = true
//        chip.trailingAnchor.constraint(equalTo: chipsStackView.trailingAnchor, constant: 0).isActive = true
        chipsStackView.addArrangedSubview(chip)
    }
}
