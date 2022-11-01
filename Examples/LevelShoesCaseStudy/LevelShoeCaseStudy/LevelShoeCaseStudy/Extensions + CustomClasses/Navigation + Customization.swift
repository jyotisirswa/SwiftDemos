//
//  Navigation + Customization.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 27/10/2022.
//

import Foundation
import UIKit

@objc protocol Navigatable: NSObjectProtocol {
    func barButtonTapped()
}

extension Navigatable where Self: UIViewController {
    func setupNavigationBar(rightBarButtonImage : String, title : String) {
        let menuButton = UIBarButtonItem(image: UIImage(named: rightBarButtonImage), style: .plain, target: self, action: #selector(barButtonTapped))
        navigationItem.rightBarButtonItem = menuButton
        navigationItem.title = title
        navigationController?.navigationBar.tintColor = .black
    }
}
