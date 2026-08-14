//
//  SplashScreen.swift
//  FieldTechy
//
//  Created by Kowsalya on 06/08/26.
//

import Foundation
import UIKit

class SplashScreenVC: UIViewController{
    
    //MARK: - Variable decalartion
    @IBOutlet weak var applogoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        //Start small — same as scale: 0.6
        applogoImageView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        applogoImageView.alpha = 0.5
        startZoomAnimation()
    }
    
    private func startZoomAnimation() {

            //  Zoom-in animation
            UIView.animate(
                withDuration: 1.0,
                delay: 0,
                options: .curveEaseOut,
                animations: {
                    // Scale to full size
                    self.applogoImageView.transform = .identity
                    self.applogoImageView.alpha = 8.0
                },
                completion: { _ in
                    // Navigate after delay
                    self.navigateToNextScreen()
                }
            )
        }
    private func navigateToNextScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            print("Navigate to next screen....")
            
            let vc = Singleton.shared.storyBoard(storyboard: "OnboardingView", identifier: "OnboardingVC")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
