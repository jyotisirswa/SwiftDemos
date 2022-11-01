//
//  ShoppingItemDetailViewController.swift
//  LevelShoeCaseStudy
//  Created by Jyoti on 18/10/2022.
//

import UIKit

class ShoppingItemDetailViewController: UIViewController {

    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewItemDetails.register(ShopItemDetailCell.nib, forCellReuseIdentifier: "shopItemDetailCell")
        setBackButton()
        if let presenterObj = presenter {
            presenterObj.viewDidLoad()
            NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveReloadNotification(notification:)), name:  Notification.Name("RELOAD_NOTIFICATION"), object: nil)
        }
    }
    
    //MARK: Properties & Variables
    @IBOutlet weak var tableViewItemDetails: UITableView!
    @IBOutlet weak var navRightBarButton: UIBarButtonItem! 
    var presenter : ViewToPresenterShopItemDetailProtocol?
    
    @IBAction private func wishListCompleted(_ sender: UIBarButtonItem) {
        guard let shoppingItem =  self.presenter?.shopItem else {
            return
        }
        self.presenter?.wishListOrAddToCartItem(shoppingItem, addRealMObjectType: .wishList)
        //self.updateShopDetailsData(shopItem: shoppingItem)
    }
    
    @objc func didReceiveReloadNotification(notification: NSNotification) {
        if self.presenter?.shopItem != nil {
            self.updateShopDetailsData(shopItem: self.presenter?.shopItem)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: - ShoppingItemDetailView + UITableViewDelegate
extension ShoppingItemDetailViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCell(withIdentifier: "shopItemDetailCell") as! ShopItemDetailCell
        if let shopItem = self.presenter?.shopItem {
            headerView.shoppingItem = shopItem
            headerView.currency = self.presenter?.otherData.currency ?? ""
            headerView.configureWith(shopItem, currency: self.presenter?.otherData.currency ?? "") { [weak self] shopItem in
                self?.presenter?.wishListOrAddToCartItem(shopItem, addRealMObjectType: .addToBag)
            }
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.tableViewItemDetails.frame.size.height
    }
}

extension ShoppingItemDetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension ShoppingItemDetailViewController : PresenterToViewShopItemDetailProtocol {
    func updateShopDetailsData(shopItem: ListItem?) {
        guard let shopItemObj = shopItem, self.tableViewItemDetails != nil else {
            return
        }
        tableViewItemDetails.delegate = self
        self.navRightBarButton.image =  shopItemObj.isWishListed ? #imageLiteral(resourceName: "wishListedNavButton") : #imageLiteral(resourceName: "wishlistNavButton")
        self.tableViewItemDetails.reloadData()
    }
}


