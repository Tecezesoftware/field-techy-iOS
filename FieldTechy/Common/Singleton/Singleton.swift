//
//  NavigationManager.swift
//  FieldTechy
//
//  Created by Kowsalya on 06/08/26.
//

import UIKit

final class Singleton {
    static let shared = Singleton()
    static var isClient = false
    
    private init() {}
    
    func storyBoard(storyboard name: String, identifier: String) -> UIViewController {
        UIStoryboard(name: name, bundle: nil)
            .instantiateViewController(withIdentifier: identifier)
    }
    
    func register(in tableView: UITableView, nameOfAllCells cells: [String]) {
        for cell in cells{
            tableView.register(
                UINib(nibName: cell, bundle: nil),
                forCellReuseIdentifier: cell
            )
        }
    }
    
}
