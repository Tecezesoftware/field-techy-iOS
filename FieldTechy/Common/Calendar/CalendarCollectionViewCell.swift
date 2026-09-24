//
//  CalendarCollectionViewCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 31/08/26.
//

import UIKit

final class CalendarCollectionViewCell: UICollectionViewCell {

    private let dateLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {

        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        dateLabel.textAlignment = .center
        dateLabel.font = .systemFont(
            ofSize: 16,
            weight: .semibold
        )

        contentView.addSubview(dateLabel)

        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),

            dateLabel.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),

            dateLabel.widthAnchor.constraint(
                equalToConstant: 40
            ),

            dateLabel.heightAnchor.constraint(
                equalToConstant: 40
            )
        ])
    }

    func configure(
        date: Date,
        isCurrentMonth: Bool,
        isSelected: Bool
    ) {

        let calendar = Calendar.current

        dateLabel.text = "\(calendar.component(.day, from: date))"

        if isSelected {

            dateLabel.backgroundColor = UIColor(
                red: 0,
                green: 0.62,
                blue: 0.40,
                alpha: 1
            )

            dateLabel.textColor = .white

            dateLabel.layer.cornerRadius = 20
            dateLabel.clipsToBounds = true

        } else {

            dateLabel.backgroundColor = .clear

            dateLabel.textColor = isCurrentMonth
                ? UIColor(red: 0.12, green: 0.15, blue: 0.25, alpha: 1)
                : UIColor.systemGray
        }
    }
}
