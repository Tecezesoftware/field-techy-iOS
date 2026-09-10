//
//  EngineerProfileVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 10/09/26.
//

import UIKit

class EngineerProfileVC: UIViewController {

    @IBOutlet weak var profileContainerView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var JoinedDateLabel: UILabel!
    
    @IBOutlet weak var PersonalInfoContainerView: UIView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var professionalInfoContainerView: UIView!
    @IBOutlet weak var skillStackView: UIStackView!
    @IBOutlet weak var skillView: UIView!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var skillLevelLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var certificateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileContainerView.layer.cornerRadius = 10
        profileContainerView.layer.borderWidth = 1
        profileContainerView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        
        PersonalInfoContainerView.layer.cornerRadius = 10
        PersonalInfoContainerView.layer.borderWidth = 1
        PersonalInfoContainerView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        
        professionalInfoContainerView.layer.cornerRadius = 10
        professionalInfoContainerView.layer.borderWidth = 1
        professionalInfoContainerView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
    }
    
    @IBAction func back(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
