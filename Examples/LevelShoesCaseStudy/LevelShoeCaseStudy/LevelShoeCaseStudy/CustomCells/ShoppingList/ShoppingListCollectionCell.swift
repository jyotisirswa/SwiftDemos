//
//  ShoppingListCollectionCell.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 16/10/2022.
//

import UIKit
import SwiftUI



class ShoppingListCollectionCell: UICollectionViewCell {
    
    //MARK: - Properties & Variables
    @IBOutlet weak var tagView: TagViews!
    @IBOutlet weak var imageViewItemImage: CustomImageView! {
        didSet {
            imageViewItemImage.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var imageViewWishList: UIImageView! {
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(wishListComplete(tapGestureRecognizer:)))
            tapGestureRecognizer.numberOfTapsRequired = 1
            tapGestureRecognizer.cancelsTouchesInView = false;
            tapGestureRecognizer.delaysTouchesBegan = true;
            imageViewWishList.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @IBOutlet weak var labelBrandName: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelOriginalPrice: UILabel!
    @IBOutlet weak var viewShadow: UIView! {
        didSet {
            viewShadow.dropShadow()
        }
    }
    var onWishListCompleted: ((UICollectionViewCell) -> Void)?
    var currency  = ""
    var shoppingItem : ListItem? {
        didSet {
            self.setupItemImage()
            self.labelBrandName.text = shoppingItem?.brand
            self.labelName.text = shoppingItem?.name
            if let priceObj = shoppingItem?.price {
                self.labelPrice.text = "\(priceObj) \(currency)"
            }
            if let originalPrice = shoppingItem?.originalPrice.value {
                self.labelOriginalPrice.text = "\(originalPrice) \(currency)"
                self.labelOriginalPrice.strikeThrough(true)
            }
            else {
                self.labelOriginalPrice.text = ""
                self.labelOriginalPrice.strikeThrough(false)

            }
            imageViewWishList.image = shoppingItem?.isWishListed ?? false ? #imageLiteral(resourceName: "wishlisted") : #imageLiteral(resourceName: "wishlist")
            self.fillData((self.shoppingItem?.badges.map{String($0)} ?? []))
        }
    }

    
    @IBAction private func wishListComplete(tapGestureRecognizer: UITapGestureRecognizer) {
        if let imageViewObj = tapGestureRecognizer.view as? UIImageView {
            if let cell = imageViewObj.superview?.superview?.superview?.superview  as? UICollectionViewCell{
                onWishListCompleted?(cell)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func fillData(_ tagNames: [String]) -> Void {
        tagView.tagNames = tagNames
        //tagsView.intrinsicHeight
        print(tagView.frame.size.height)
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        //force layout of all subviews including RectsView, which
        //updates RectsView's intrinsic height, and thus height of a cell
        self.setNeedsLayout()
        self.layoutIfNeeded()
        //now intrinsic height is correct, so we can call super method
        return super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = UIColor.init(red: 252, green: 252, blue: 252, alpha: 1.0)
        //self.contentView.autoresizingMask = [.flexibleHeight]
    }
    
    func setupItemImage() {
        if let imageUrl = shoppingItem?.image {
            imageViewItemImage.loadImageUsingUrlString(urlString: imageUrl)
        }
    }
}

