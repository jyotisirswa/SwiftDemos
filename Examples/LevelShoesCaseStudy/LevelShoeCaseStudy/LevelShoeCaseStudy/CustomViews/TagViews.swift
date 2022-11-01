//
//  TagViews.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 30/10/2022.
//

import Foundation
import UIKit

class TagViews: UIView {
    
    var tagNames: [String] = [] {
        didSet {
            addTagLabels()
        }
    }
    
    let tagHeight:CGFloat = 20
    let tagPadding: CGFloat = 8
    let tagSpacingX: CGFloat = 8
    let tagSpacingY: CGFloat = 8

    var intrinsicHeight: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() -> Void {
    }

    func addTagLabels() -> Void {
        // if we already have tag labels (or buttons, etc)
        //  remove any excess (e.g. we had 10 tags, new set is only 7)
        while self.subviews.count > tagNames.count {
            self.subviews[0].removeFromSuperview()
        }
        
        // if we don't have enough labels, create and add as needed
        while self.subviews.count < tagNames.count {
            // create a new label
            let newLabel = UILabel()
            // set its properties (title, colors, corners, etc)
            newLabel.textAlignment = .center
            newLabel.backgroundColor = UIColor.init(named: "shadowColor") //UIColor.lightGray
            newLabel.layer.masksToBounds = true
            newLabel.layer.cornerRadius = 2
            newLabel.font = UIFont.systemFont(ofSize: 12)
            //newLabel.layer.borderColor = UIColor.red.cgColor
            //newLabel.layer.borderWidth = 1
            addSubview(newLabel)
        }

        // now loop through labels and set text and size
        for (str, v) in zip(tagNames, self.subviews) {
            guard let label = v as? UILabel else {
                fatalError("non-UILabel subview found!")
            }
            label.text = str
            label.frame.size.width = label.intrinsicContentSize.width + tagPadding
            label.frame.size.height = tagHeight
        }

    }
    
    func displayTagLabels() {
        
        var currentOriginX: CGFloat = 0
        var currentOriginY: CGFloat = 0

        // for each label in the array
        self.subviews.forEach { v in
            
            guard let label = v as? UILabel else {
                fatalError("non-UILabel subview found!")
            }

            // if current X + label width will be greater than container view width
            //  "move to next row"
            if currentOriginX + label.frame.width > bounds.width {
                currentOriginX = 0
                currentOriginY += tagHeight + tagSpacingY
            }
            
            // set the btn frame origin
            label.frame.origin.x = currentOriginX
            label.frame.origin.y = currentOriginY
            
            // increment current X by btn width + spacing
            currentOriginX += label.frame.width + tagSpacingX
            
        }
        
        // update intrinsic height
        intrinsicHeight = currentOriginY + tagHeight
        invalidateIntrinsicContentSize()
        
    }

    // allow this view to set its own intrinsic height
    override var intrinsicContentSize: CGSize {
        var sz = super.intrinsicContentSize
        sz.height = intrinsicHeight
        return sz
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        displayTagLabels()
    }
    
}
