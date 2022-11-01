//
//  ShopItemDetailCelll.swift
//  LevelShoeCaseStudy
//  Created by Jyoti on 18/10/2022.
//

import UIKit

class ShopItemDetailCell: UITableViewCell {

    //MARK: - Properties & Variables
    @IBOutlet weak var tagsView: TagViews!
    @IBOutlet weak var buttonAddToBag: UIButton!
    @IBOutlet weak var imageViewItemImage: CustomImageView! {
        didSet {
            imageViewItemImage.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var labelBrandName: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelOriginalPrice: UILabel!
        var currency  = ""
    private var onAddToCartCompleted: ((ListItem) -> Void)?
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
            }
            self.labelOriginalPrice.strikeThrough(true)
            self.buttonAddToBag.isHidden = shoppingItem?.isCartAdded == true ? true : false
            self.fillData((self.shoppingItem?.badges.map{String($0)} ?? []))

        }
    }
    @IBAction private func addToItemComplete(_ sender: UIButton) {
        guard let item = shoppingItem else { fatalError("Missing  Item") }
        onAddToCartCompleted?(item)
    }
    
    func configureWith(_ item: ListItem, currency : String, onAddToCartCompleted: ((ListItem) -> Void)? = nil) {
        self.currency = currency
        self.shoppingItem = item
        self.onAddToCartCompleted = onAddToCartCompleted
        self.buttonAddToBag.isHidden = shoppingItem?.isCartAdded == true ? true : false
    }
    
    func setupItemImage() {
        if let imageUrl = shoppingItem?.image {
            imageViewItemImage.loadImageUsingUrlString(urlString: imageUrl)
        }
    }
    
    func fillData(_ tagNames: [String]) -> Void {
        tagsView.tagNames = tagNames
        print(tagsView.frame.size.height)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
         //force layout of all subviews including RectsView, which
        //updates RectsView's intrinsic height, and thus height of a cell
        self.setNeedsLayout()
        self.layoutIfNeeded()
        //now intrinsic height is correct, so we can call super method
        return super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
    }
}
