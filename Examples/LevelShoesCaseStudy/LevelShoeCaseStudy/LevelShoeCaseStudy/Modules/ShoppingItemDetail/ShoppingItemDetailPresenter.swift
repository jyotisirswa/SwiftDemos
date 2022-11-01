//
//  ShoppingItemDetailPresenter.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 16/10/2022.
//

import Foundation


class ShoppingItemDetailPresenter : ViewToPresenterShopItemDetailProtocol {
    
    //MARK: Properties & Variables
    weak var view: PresenterToViewShopItemDetailProtocol?
    var interactor: PresenterToInteractorShopItemDetailProtocol?
    var router: PresenterToRouterShopItemDetailProtocol?
    var shopItem: ListItem? 
    var otherData: (currency : String?, tags : String?)
    
    func viewDidLoad() {
        if self.shopItem != nil {
            view?.updateShopDetailsData(shopItem: self.shopItem!)
        }
    }
    
    func wishListOrAddToCartItem(_ item: ListItem, addRealMObjectType: AddRealMObjectType) {
        self.interactor?.wishListOrAddToCartItem(item, addRealMObjectType: addRealMObjectType)
    }
}

