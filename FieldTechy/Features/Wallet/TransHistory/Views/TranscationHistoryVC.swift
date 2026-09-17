//
//  TranscationHistoryVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 16/09/26.
//

import UIKit

class TranscationHistoryVC: UIViewController {

    @IBOutlet weak var transHistoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    func registerCell(){
        Singleton.shared.register(in: transHistoryTableView, nameOfAllCells: ["TransHistoryCell"])
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension TranscationHistoryVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransHistoryCell", for: indexPath) as! TransHistoryCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
}
