//
//  CustomPopupView.swift
//  FieldTechy
//
//  Created by Kowsalya on 26/08/26.
//

import Foundation
import UIKit

final class CustomPopupView: UIView {

    // MARK: - UI Components

    // Overlay
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // Card
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor    = AppTheme.secondaryBGColor
        view.layer.cornerRadius = 20
        view.clipsToBounds      = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // Close Button
    private let closeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "CloseIcon"), for: .normal)
        btn.backgroundColor   = AppTheme.neutralLight500
        btn.layer.cornerRadius = 12
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    // Icon Background
    private let iconBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 32.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // Icon ImageView
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    // Title
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font          = AppFonts.Regular(size: 20.0)
        label.textColor     = AppTheme.primaryTextColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Subtitle
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font          = AppFonts.Regular(size: 14.0)
        label.textColor     = AppTheme.neutralLight800
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Remarks Title (for remarks type)
    private let remarksTitleLabel: UILabel = {
        let label = UILabel()
        label.font      = AppFonts.Medium(size: 14.0)
        label.textColor = AppTheme.primaryTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Remarks TextView
    private let remarksTextView: UITextView = {
        let tv = UITextView()
        tv.font             = AppFonts.Regular(size: 12.0)
        tv.textColor        = AppTheme.primaryTextColor
        tv.layer.cornerRadius = 8
        tv.layer.borderWidth  = 1
        tv.layer.borderColor  = AppTheme.borderColorOfViews.cgColor
        tv.backgroundColor    = AppTheme.secondaryBGColor
        tv.textContainerInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    // Placeholder for remarks
    private let remarksPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.font      = AppFonts.Regular(size: 14.0)
        label.textColor = AppTheme.neutralLight500
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Buttons StackView
    private let buttonsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis         = .horizontal
        sv.spacing      = 12
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    // Content StackView
    private let contentStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis      = .vertical
        sv.spacing   = 12
        sv.alignment = .center
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    // MARK: - Properties
    private var config: PopupConfig!

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Configure & Show
    func configure(with config: PopupConfig) {
        self.config = config
        setupLayout()
        setupContent()
        setupButtons()
    }

    // MARK: - Layout
    private func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(overlayView)
        addSubview(cardView)
        cardView.addSubview(closeButton)
        cardView.addSubview(contentStackView)
        cardView.addSubview(buttonsStackView)

        NSLayoutConstraint.activate([

            // Overlay fills self
            overlayView.topAnchor.constraint(equalTo: topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),

            // Card — centered
            cardView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cardView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.82),

            // Close button — top right
            closeButton.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            closeButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            closeButton.widthAnchor.constraint(equalToConstant: 34),
            closeButton.heightAnchor.constraint(equalToConstant: 34),

            // Content stack
            contentStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 32),
            contentStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),

            // Buttons stack
            buttonsStackView.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 20),
            buttonsStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            buttonsStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 48)
        ])

        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        if config.isDismissable {
            let tap = UITapGestureRecognizer(target: self, action: #selector(overlayTapped))
            overlayView.addGestureRecognizer(tap)
        }
    }

    // MARK: - Content Setup
    private func setupContent() {
        contentStackView.arrangedSubviews.forEach {
            contentStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        // Icon
        if case .none = config.iconType {
            // skip icon
        } else {
            setupIcon()
            contentStackView.addArrangedSubview(iconBackgroundView)
        }

        // Title
        titleLabel.text = config.title
        contentStackView.addArrangedSubview(titleLabel)

        switch config.type {
        case .status, .confirmation, .alert:
            if let subtitle = config.subtitle, !subtitle.isEmpty {
                subtitleLabel.text = subtitle
                contentStackView.addArrangedSubview(subtitleLabel)
            }

        case .remarks(let placeholder):
            setupRemarks(placeholder: placeholder)
            contentStackView.alignment = .fill
            contentStackView.addArrangedSubview(remarksTitleLabel)
            contentStackView.addArrangedSubview(remarksTextView)

            NSLayoutConstraint.activate([
                remarksTextView.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
    }

    // MARK: - Icon Setup
    private func setupIcon() {
        // Remove previous subviews
        iconBackgroundView.subviews.forEach { $0.removeFromSuperview() }
        iconBackgroundView.addSubview(iconImageView)

        NSLayoutConstraint.activate([
            iconBackgroundView.widthAnchor.constraint(equalToConstant: 72),
            iconBackgroundView.heightAnchor.constraint(equalToConstant: 72),

            iconImageView.centerXAnchor.constraint(equalTo: iconBackgroundView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconBackgroundView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 32),
            iconImageView.heightAnchor.constraint(equalToConstant: 32)
        ])

        switch config.iconType {
        case .success:
            iconBackgroundView.backgroundColor = UIColor(hex: "2E8B57")
            iconImageView.image  = UIImage(systemName: "checkmark")
            iconImageView.tintColor = .white

        case .error:
            iconBackgroundView.backgroundColor = UIColor(hex: "EF4444")
            iconImageView.image  = UIImage(systemName: "xmark")
            iconImageView.tintColor = .white

        case .warning:
            iconBackgroundView.backgroundColor = UIColor(hex: "F59E0B")
            iconImageView.image  = UIImage(systemName: "exclamationmark.triangle")
            iconImageView.tintColor = .white

        case .logout:
            iconBackgroundView.backgroundColor = AppTheme.neutralLight500
            iconImageView.image  = UIImage(named: "ExitDoorIcon")

        case .custom(let image, let bgColor):
            iconBackgroundView.backgroundColor = bgColor
            iconImageView.image  = image
            iconImageView.tintColor = .white

        case .none:
            break
        }
    }

    // MARK: - Remarks Setup
    private func setupRemarks(placeholder: String) {
        remarksTitleLabel.text             = "Remarks"
        remarksPlaceholderLabel.text       = placeholder
        remarksTextView.delegate           = self

        remarksTextView.addSubview(remarksPlaceholderLabel)
        NSLayoutConstraint.activate([
            remarksPlaceholderLabel.topAnchor.constraint(equalTo: remarksTextView.topAnchor, constant: 12),
            remarksPlaceholderLabel.leadingAnchor.constraint(equalTo: remarksTextView.leadingAnchor, constant: 12)
        ])
    }

    // MARK: - Buttons Setup
    private func setupButtons() {
        buttonsStackView.arrangedSubviews.forEach {
            buttonsStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        config.buttons.enumerated().forEach { index, buttonConfig in
            let button = buildButton(config: buttonConfig, tag: index)
            buttonsStackView.addArrangedSubview(button)
        }
    }

    private func buildButton(config: PopupButton, tag: Int) -> UIButton {
        let button = UIButton()
        button.setTitle(config.title, for: .normal)
        button.titleLabel?.font = AppFonts.Medium(size: 16)
        button.layer.cornerRadius = button.layer.frame.height / 2
        button.tag = tag

        switch config.style {
        case .primary:
            button.backgroundColor = AppTheme.primaryButtonTextColor
            button.setTitleColor(AppTheme.primaryButtonBGColor, for: .normal)

        case .secondary:
            button.backgroundColor = AppTheme.neutralLight500
            button.setTitleColor(AppTheme.primaryTextColor, for: .normal)

        case .destructive:
            button.backgroundColor = UIColor(hex: "EF4444")
            button.setTitleColor(.white, for: .normal)

        case .outline:
            button.backgroundColor    = .white
            button.layer.borderWidth  = 1.5
            button.layer.borderColor  = UIColor(hex: "E5E7EB").cgColor
            button.setTitleColor(UIColor(hex: "26272C"), for: .normal)
        }

        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }

    // MARK: - Actions
    @objc private func buttonTapped(_ sender: UIButton) {
        let buttonConfig = config.buttons[sender.tag]

        // Remarks type — pass text back
        if case .remarks = config.type {
            let text = remarksTextView.text ?? ""
            config.onRemarksSubmit?(text)
        }

        dismiss {
            buttonConfig.action?()
        }
    }

    @objc private func closeButtonTapped() {
        dismiss { [weak self] in
            self?.config.onDismiss?()
        }
    }

    @objc private func overlayTapped() {
        guard config.isDismissable else { return }
        dismiss { [weak self] in
            self?.config.onDismiss?()
        }
    }

    // MARK: - Show & Dismiss Animation
    func show(in view: UIView) {
        view.addSubview(self)

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // Animate in
        overlayView.alpha       = 0
        cardView.alpha          = 0
        cardView.transform      = CGAffineTransform(scaleX: 0.8, y: 0.8)

        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: .curveEaseOut
        ) {
            self.overlayView.alpha  = 1
            self.cardView.alpha     = 1
            self.cardView.transform = .identity
        }
    }

    func dismiss(completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.overlayView.alpha  = 0
                self.cardView.alpha     = 0
                self.cardView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            },
            completion: { _ in
                self.removeFromSuperview()
                completion?()
            }
        )
    }
}

// MARK: - UITextViewDelegate
extension CustomPopupView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        remarksPlaceholderLabel.isHidden = !textView.text.isEmpty
    }
}
