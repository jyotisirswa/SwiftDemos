//
//  UIViews + Customization.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 01/11/2022.
//

import Foundation
import UIKit


extension UIView {
    public class var nibName: String {
        let name = "\(self)".components(separatedBy: ".").first ?? ""
        return name
    }
    public class var nib: UINib? {
        if let _ = Bundle.main.path(forResource: nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: nil)
        } else {
            return nil
        }
    }
    
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.init(named: "shadowColor")?.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowRadius = 4.0
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.cornerRadius = 5.0
    }
}

extension UILabel {
    public var getHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    
    func strikeThrough(_ isStrikeThrough: Bool = true) {
        guard let text = self.text else {
            return
        }
        if isStrikeThrough {
            let attributeString =  NSMutableAttributedString(string: text)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
            self.attributedText = attributeString
        } else {
            let attributeString =  NSMutableAttributedString(string: text)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: [], range: NSMakeRange(0,attributeString.length))
            self.attributedText = attributeString
        }
    }
}

extension UIButton {
    func underlineText() {
        let attributedString = NSAttributedString(string: NSLocalizedString(self.titleLabel?.text ?? "", comment: ""), attributes:[
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
            NSAttributedString.Key.foregroundColor : UIColor.gray,
            NSAttributedString.Key.underlineStyle:1.0
        ])
        setAttributedTitle(attributedString, for: .normal)
    }
}

let yourAttributes: [NSAttributedString.Key: Any] = [
     .font: UIFont.systemFont(ofSize: 14),
     .foregroundColor: UIColor.blue,
     .underlineStyle: NSUnderlineStyle.single.rawValue
 ] // .double.rawValue, .thick.rawValue
   
