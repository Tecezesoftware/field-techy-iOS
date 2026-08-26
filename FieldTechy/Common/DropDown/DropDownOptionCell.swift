//
//  DropDownOptionCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 11/08/26.
//

import UIKit

final class DropDownOptionCell: UITableViewCell {

    // MARK: - UI
    private let optionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 15)
            ?? .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let selectedIndicator: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Setup
    private func setupUI() {
        selectionStyle = .none

        contentView.addSubview(selectedIndicator)
        contentView.addSubview(optionLabel)

        NSLayoutConstraint.activate([
            // Selected indicator — left edge accent bar
            selectedIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            selectedIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            selectedIndicator.widthAnchor.constraint(equalToConstant: 4),
            selectedIndicator.heightAnchor.constraint(equalToConstant: 24),

            // Option label
            optionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            optionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            optionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    // MARK: - Configure
    func configure(
        text: String,
        isSelected: Bool,
        selectedBgColor: UIColor,
        selectedFgColor: UIColor,
        normalBgColor: UIColor,
        normalFgColor: UIColor
    ) {
        optionLabel.text = text

        if isSelected {
            // ✅ Selected state
            contentView.backgroundColor   = selectedBgColor
            optionLabel.textColor         = selectedFgColor
            optionLabel.font              = UIFont(name: "Poppins-Medium", size: 15)
                ?? .boldSystemFont(ofSize: 15)
            selectedIndicator.isHidden    = false
            selectedIndicator.backgroundColor = selectedFgColor
        } else {
            // Normal state
            contentView.backgroundColor   = normalBgColor
            optionLabel.textColor         = normalFgColor
            optionLabel.font              = UIFont(name: "Poppins-Regular", size: 15)
                ?? .systemFont(ofSize: 15)
            selectedIndicator.isHidden    = true
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.backgroundColor = .white
        selectedIndicator.isHidden  = true
    }
}
