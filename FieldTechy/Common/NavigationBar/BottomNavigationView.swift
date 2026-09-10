//
//  BottomNavigationView.swift
//  FieldTechy
//
//  Created by Kowsalya on 24/08/26.
//

import UIKit

enum BottomNavItem: Int, CaseIterable {
    case dashboard
    case jobs
    case wallet
    case dispute

    var imageName: String {
        switch self {
        case .dashboard:
            return "Dashboard"
        case .jobs:
            return "Jobs"
        case .wallet:
            return "Wallet"
        case .dispute:
            return "Dispute"
        }
    }
}

final class BottomNavigationView: UIView {

    // MARK: - Properties

    private var buttons: [UIButton] = []

    var selectedItem: BottomNavItem = .dashboard {
        didSet {
            updateSelection()
        }
    }

    var onItemSelected: ((BottomNavItem) -> Void)?

    // MARK: - UI

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupItems()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupItems()
    }

    // MARK: - Setup

    private func setupUI() {

        backgroundColor = AppTheme.primaryButtonLabelColor

        layer.cornerRadius = 20
        clipsToBounds = false

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.12
        layer.shadowOffset = CGSize(width: 0, height: -2)
        layer.shadowRadius = 20

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 8
            ),

            stackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 8
            ),

            stackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -8
            ),

            stackView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -8
            )
        ])
    }

    private func setupItems() {

        BottomNavItem.allCases.forEach { item in

            let button = UIButton(type: .custom)
            button.tag = item.rawValue
            button.setImage(
                UIImage(
                    named: ("\(item.imageName)-Unselected")
                ),
                for: .normal
            )

            button.addTarget(
                self,
                action: #selector(itemTapped(_:)),
                for: .touchUpInside
            )

            stackView.addArrangedSubview(button)
            buttons.append(button)
        }

        updateSelection()
    }

    // MARK: - Action

    @objc private func itemTapped(_ sender: UIButton) {
        guard let item = BottomNavItem(rawValue: sender.tag) else { return }
        selectedItem = item
        onItemSelected?(item)
    }

    // MARK: - Update UI

    private func updateSelection() {

        for button in buttons {

            guard let item = BottomNavItem(
                rawValue: button.tag
            ) else {
                continue
            }

           if item == selectedItem {
                let imageName = "\(item.imageName)-Selected"
               button.setImage(UIImage(named: imageName), for: .normal)
           }else{
               let imageName = "\(item.imageName)-Unselected"
              button.setImage(UIImage(named: imageName), for: .normal)
           }
        }
    }
    
    func updateViewConstraints(view: UIView, bottomNavigationView: BottomNavigationView) {
        NSLayoutConstraint.activate([
            bottomNavigationView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),
            
            bottomNavigationView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            ),
            
            bottomNavigationView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -8
            ),
            
            bottomNavigationView.heightAnchor.constraint(
                equalToConstant: 80
            )
        ])
    }
}
