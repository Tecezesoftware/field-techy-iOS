//
//  RatingView.swift
//  FieldTechy
//
//  Created by Kowsalya on 08/09/26.
//

import UIKit

class RatingView: UIView {

    @IBOutlet weak var technicalSkillStackView: UIStackView!
    @IBOutlet weak var technicalSkillStarsStackView: UIStackView!
    @IBOutlet weak var techStar1: UIButton!
    @IBOutlet weak var techStar2: UIButton!
    @IBOutlet weak var techStar3: UIButton!
    @IBOutlet weak var techStar4: UIButton!
    @IBOutlet weak var techStar5: UIButton!
    
    @IBOutlet weak var toolSkillStackView: UIStackView!
    @IBOutlet weak var toolSkillStarStackView: UIStackView!
    @IBOutlet weak var toolStar1: UIButton!
    @IBOutlet weak var toolStar2: UIButton!
    @IBOutlet weak var toolStar3: UIButton!
    @IBOutlet weak var toolStar4: UIButton!
    @IBOutlet weak var toolStar5: UIButton!
    
    @IBOutlet weak var communicationStackView: UIStackView!
    @IBOutlet weak var communicationStarStackView: UIStackView!
    @IBOutlet weak var comStar1: UIButton!
    @IBOutlet weak var comStar2: UIButton!
    @IBOutlet weak var comStar3: UIButton!
    @IBOutlet weak var comStar4: UIButton!
    @IBOutlet weak var comStar5: UIButton!
    
    @IBOutlet weak var overallRatingLabel: UILabel!
    @IBOutlet weak var feedBackTextField: UITextField!
    
    private var techSelectedRating = 0
    private var techStarButtons: [UIButton] {
        [
            techStar1,
            techStar2,
            techStar3,
            techStar4,
            techStar5
        ]
    }
    
    private var toolSelectedRating = 0
    private var toolStarButtons: [UIButton] {
        [
            toolStar1,
            toolStar2,
            toolStar3,
            toolStar4,
            toolStar5
        ]
    }
    
    private var comSelectedRating = 0
    private var comStarButtons: [UIButton] {
        [
            comStar1,
            comStar2,
            comStar3,
            comStar4,
            comStar5
        ]
    }
    
    @IBAction func techAction(_ sender: UIButton) {
        guard let rating = techStarButtons.firstIndex(of: sender) else {
                return
            }
            techSelectedRating = rating + 1

        updateStars(starButtons: techStarButtons, selectedRating: techSelectedRating)
    }
    
    @IBAction func toolAction(_ sender: UIButton) {
        guard let rating = toolStarButtons.firstIndex(of: sender) else {
            return
        }
        toolSelectedRating = rating + 1
        updateStars(starButtons: toolStarButtons, selectedRating: toolSelectedRating)
    }
    
    @IBAction func commAction(_ sender: UIButton) {
       guard let rating = comStarButtons.firstIndex(of: sender) else {
            return
        }
        comSelectedRating = rating + 1
        updateStars(starButtons: comStarButtons, selectedRating: comSelectedRating)
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        guard techSelectedRating > 0, toolSelectedRating > 0, comSelectedRating > 0 else {
            print("Please select a rating")
            return
        }
        
        let review = feedBackTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        print("Review and Rating: \(review ?? "No review"), \(techSelectedRating), \(toolSelectedRating), \(comSelectedRating)")
    }
    
    private func updateStars(starButtons: [UIButton], selectedRating: Int) {

        for (index, button) in starButtons.enumerated() {

            let imageName = index < selectedRating
                ? "FilledStar"
                : "UnfilledStar"

            button.setImage(
                UIImage(named: imageName),
                for: .normal
            )
        }
    }
}

extension RatingView {
    static func loadFromXIB() -> RatingView? {
        let nib = UINib(
            nibName: "RatingView",
            bundle: nil
        )

        return nib.instantiate(
            withOwner: nil,
            options: nil
        ).first as? RatingView
    }
}
