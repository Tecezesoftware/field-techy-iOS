//
//  PostSuccessVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 03/09/26.
//

import UIKit

class PostSuccessVC: UIViewController {

    @IBOutlet weak var contentview: UIView!
    @IBOutlet weak var jobId: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var skillLevel: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var totalPaid: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        contentview.layer.cornerRadius = 5
        contentview.layer.borderWidth = 1.5
        contentview.layer.borderColor = AppTheme.borderColorOfViews.cgColor
    }
 
    @IBAction func OntapViewMyJob(_ sender: Any){
        let vc = Singleton.shared.storyBoard(storyboard: "MyJobs", identifier: "MyJobsVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
