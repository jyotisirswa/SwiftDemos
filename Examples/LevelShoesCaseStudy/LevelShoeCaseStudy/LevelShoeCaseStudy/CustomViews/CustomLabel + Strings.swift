//
//  CustomLabel + Strings.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 31/10/2022.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    override var text: String? {
        didSet {
            super.text = text?.uppercased()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        super.text = text?.uppercased()
    }
}
