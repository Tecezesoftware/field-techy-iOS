//
//  Array+Safe.swift
//  FieldTechy
//
//  Created by Kowsalya on 11/08/26.
//

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
