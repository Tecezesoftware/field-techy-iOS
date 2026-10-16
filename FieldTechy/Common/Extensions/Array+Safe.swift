//
//  Array+Safe.swift
//  FieldTechy
//
//  Created by Kowsalya on 11/08/26.
//

import UIKit

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

extension UIView {

    static func loadFromXIB<T: UIView>() -> T {

        let nibName = String(describing: T.self)

        guard let view = Bundle.main.loadNibNamed(
            nibName,
            owner: nil,
            options: nil
        )?.first as? T else {
            fatalError(
                "Could not load \(nibName). Check XIB name and Custom Class."
            )
        }

        return view
    }
}
