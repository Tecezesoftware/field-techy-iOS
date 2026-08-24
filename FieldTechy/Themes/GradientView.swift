//
//  GradientView.swift
//  FieldTechy
//
//  Created by Kowsalya on 24/08/26.
//
import UIKit

@IBDesignable
class GradientView: UIView {

    private let gradientLayer = CAGradientLayer()

    @IBInspectable var startColor: UIColor = .clear {
        didSet {
            updateGradient()
        }
    }

    @IBInspectable var endColor: UIColor = .clear {
        didSet {
            updateGradient()
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            updateGradient()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }

    // Important for Storyboard / Interface Builder
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        setupGradient()
        updateGradient()

        gradientLayer.frame = bounds
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = cornerRadius
    }

    private func setupGradient() {

        if gradientLayer.superlayer == nil {
            layer.insertSublayer(gradientLayer, at: 0)
        }

        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)

        updateGradient()
    }

    private func updateGradient() {

        gradientLayer.colors = [
            startColor.cgColor,
            endColor.cgColor
        ]

        gradientLayer.setNeedsDisplay()
    }
}
