//
//  DashedBorderView.swift
//  FieldTechy
//
//  Created by Kowsalya on 31/08/26.
//

import Foundation
import UIKit

@IBDesignable
final class DashedBorderView: UIView {

    // MARK: - Border Style

    enum BorderStyle {
        case solid
        case dashed
    }

    // MARK: - Inspectable Properties

    @IBInspectable
    var borderColor: UIColor = .systemGray {
        didSet {
            updateBorder()
        }
    }

    @IBInspectable
    var borderWidth: CGFloat = 1.0 {
        didSet {
            updateBorder()
        }
    }

    @IBInspectable
    var cornerRadius: CGFloat = 8.0 {
        didSet {
            updateBorder()
        }
    }

    /// Space between the actual view bounds and the border.
    @IBInspectable
    var borderPadding: CGFloat = 0.0 {
        didSet {
            updateBorder()
        }
    }

    /// Length of each visible dash.
    @IBInspectable
    var dashLength: CGFloat = 6.0 {
        didSet {
            updateBorder()
        }
    }

    /// Space between dashes.
    @IBInspectable
    var dashSpacing: CGFloat = 4.0 {
        didSet {
            updateBorder()
        }
    }

    /// Set true for dashed border, false for solid border.
    @IBInspectable
    var isDashed: Bool = true {
        didSet {
            updateBorder()
        }
    }

    // MARK: - Private Properties

    private let borderLayer = CAShapeLayer()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Setup

    private func setup() {

        // Prevent the view itself from drawing a default border.
        layer.borderWidth = 0

        // Configure shape layer once.
        borderLayer.fillColor = UIColor.clear.cgColor

        layer.addSublayer(borderLayer)

        // Makes the view behave nicely with Auto Layout.
        clipsToBounds = false
    }

    // MARK: - Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        updateBorder()
    }

    // MARK: - Border Configuration

    private func updateBorder() {

        guard bounds.width > 0, bounds.height > 0 else {
            return
        }

        let inset = borderWidth / 2 + borderPadding

        let borderRect = bounds.insetBy(
            dx: inset,
            dy: inset
        )

        // Configure border layer.
        borderLayer.frame = bounds
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.fillColor = UIColor.clear.cgColor

        // Solid / Dashed
        if isDashed {
            borderLayer.lineDashPattern = [
                dashLength as NSNumber,
                dashSpacing as NSNumber
            ]
        } else {
            borderLayer.lineDashPattern = nil
        }

        // Rounded path.
        let radius = max(
            0,
            min(
                cornerRadius,
                min(borderRect.width, borderRect.height) / 2
            )
        )

        borderLayer.path = UIBezierPath(
            roundedRect: borderRect,
            cornerRadius: radius
        ).cgPath

        // Keep the border layer behind subviews.
        layer.insertSublayer(borderLayer, at: 0)
    }
}
