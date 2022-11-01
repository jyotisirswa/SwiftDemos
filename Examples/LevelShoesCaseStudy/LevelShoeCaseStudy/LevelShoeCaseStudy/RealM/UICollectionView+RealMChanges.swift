//
//  UICollectionView+RealMChanges.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 25/10/2022.
//

import Foundation
import UIKit

extension IndexPath {
  static func fromRow(_ row: Int) -> IndexPath {
    return IndexPath(item: row, section: 0)
  }
}

extension UICollectionView {
    func applyChanges(deletions: [Int], insertions: [Int], updates: [Int]) {
        performBatchUpdates({
            insertItems(at: insertions.map { IndexPath(item: $0, section: 0) })
            deleteItems(at: deletions.map { IndexPath(item: $0, section: 0)  })
            reloadItems(at: updates.map {IndexPath(item: $0, section: 0)  })
        }, completion: { (completed: Bool) in
            self.reloadData()
        })
    }
}
