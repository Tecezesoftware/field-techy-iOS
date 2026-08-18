//
//  EngineerSignUpContainerVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 17/08/26.
//

import UIKit

class EngineerSignUpContainerVC: UIViewController {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var stepTitleLabel: UILabel!
    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var progressStackView: UIStackView!
    @IBOutlet weak var contentContainerView: UIView!
    
    // MARK: - Properties
        private var currentStep  = 0  // 0-indexed
        private let totalSteps   = 3
        private var progressBars = [UIView]()

        private let sharedModel  = EngineerSignUpModel()
    
    // Step ViewControllers
//        private lazy var step1VC = EngineerStep1VC(model: sharedModel)
//        private lazy var step2VC = EngineerStep2VC(model: sharedModel)
//        private lazy var step3VC = EngineerStep3VC(model: sharedModel)

        private var stepTitles = [
            "Personal Details",
            "Skills & Rates",
            "Preferences"
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProgressBars()
        showStep(0, animated: false)
    }
    
    
    // MARK: - Progress Bars
    private func setupProgressBars() {
        for i in 0..<totalSteps {
            let bar = UIView()
            bar.layer.cornerRadius = 2
            bar.backgroundColor    = i == 0
                ? UIColor(hex: "2E8B57")   // active — green
                : UIColor(hex: "E5E7EB")   // inactive — gray
            progressBars.append(bar)
            progressStackView.addArrangedSubview(bar)
        }
    }

    private func updateProgressBars(for step: Int) {
        for (index, bar) in progressBars.enumerated() {
            UIView.animate(withDuration: 0.3) {
                bar.backgroundColor = index <= step
                    ? UIColor(hex: "2E8B57")
                    : UIColor(hex: "E5E7EB")
            }
        }
    }
    // MARK: - Step Navigation
        private func showStep(_ step: Int, animated: Bool) {
            let stepVCs: [UIViewController] = [/*step1VC, step2VC, step3VC*/]
            let targetVC = stepVCs[step]

            // Remove current child if exists
            children.forEach {
                $0.willMove(toParent: nil)
                $0.view.removeFromSuperview()
                $0.removeFromParent()
            }

            // Add new child
            addChild(targetVC)
            targetVC.view.translatesAutoresizingMaskIntoConstraints = false
            contentContainerView.addSubview(targetVC.view)

            NSLayoutConstraint.activate([
                targetVC.view.topAnchor.constraint(equalTo: contentContainerView.topAnchor),
                targetVC.view.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor),
                targetVC.view.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor),
                targetVC.view.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor)
            ])
            targetVC.didMove(toParent: self)

            // Animate slide
            if animated {
                let direction: CGFloat = step > currentStep ? 1 : -1
                targetVC.view.transform = CGAffineTransform(
                    translationX: direction * contentContainerView.bounds.width,
                    y: 0
                )
                UIView.animate(withDuration: 0.35, delay: 0.7, options: .curveEaseInOut) {
                    targetVC.view.transform = .identity
                }
            }

            // Update UI
            currentStep                = step
            stepTitleLabel.text        = "Create Engineer Account"
            stepCountLabel.text        = "\(step + 1)/\(totalSteps)"
            updateProgressBars(for: step)
        }

        // MARK: - Public Navigation (Called by child VCs)
        func goToNextStep() {
            guard currentStep < totalSteps - 1 else {
                submitAllSteps()
                return
            }
            showStep(currentStep + 1, animated: true)
        }

        func goToPreviousStep() {
            guard currentStep > 0 else { return }
            showStep(currentStep - 1, animated: true)
        }

        // MARK: - Final Submit
        private func submitAllSteps() {
            print("✅ All steps complete — submitting")
            print("Name: \(sharedModel.firstName) \(sharedModel.lastName)")
            print("Skills: \(sharedModel.selectedSkills)")
            print("Onsite: \(sharedModel.onsiteJobs)")
        }
}
