//
//  WishListCustomCell.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 27/10/2022.
//

import UIKit

class WishListCustomCell: UITableViewCell {
    
    //MARK: - Properties & Variables
    @IBOutlet weak var tagsView: TagViews!
    @IBOutlet weak var buttonRemove: UIButton!
    @IBOutlet weak var stackViewRemove: UIStackView!  {
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(wishListComplete(tapGestureRecognizer:)))
            tapGestureRecognizer.numberOfTapsRequired = 1
            tapGestureRecognizer.cancelsTouchesInView = false;
            tapGestureRecognizer.delaysTouchesBegan = true;
            stackViewRemove.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @IBOutlet weak var imageViewItemImage: CustomImageView! {
        didSet {
            imageViewItemImage.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var labelBrandName: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelOriginalPrice: UILabel!
    private var onRemoveWishListCompleted: ((ListItem) -> Void)?
    private var currency  = ""
    private var shoppingItem : ListItem? {
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
            self.buttonRemove.underlineText()
            self.fillData((self.shoppingItem?.badges.map{String($0)} ?? []))
        }
    }
    
    @IBAction private func wishListComplete(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let item = shoppingItem else { fatalError("Missing wishList Item") }
        UIApplication.shared.keyWindowPresentedController?.presentAlertWithTitleAndMessage(title: "Are you sure?", message: "You want to remove this item from list?", options: "Yes", "No", completion: { indexObj in
            //print(options)
            indexObj == 0 ? self.onRemoveWishListCompleted?(item) : print("Alert dismissed")
        })
    }
    
    func configureWith(_ item: ListItem, currency : String, onRemoveWishListCompleted: ((ListItem) -> Void)? = nil) {
        self.currency = currency
        self.shoppingItem = item
        self.onRemoveWishListCompleted = onRemoveWishListCompleted
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
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
