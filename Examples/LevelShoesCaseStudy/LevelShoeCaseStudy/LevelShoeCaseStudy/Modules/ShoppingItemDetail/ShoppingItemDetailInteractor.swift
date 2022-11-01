//
//  ShoppingItemDetailInteractor.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 16/10/2022.
//

import Foundation

class ShoppingItemDetailInteractor : PresenterToInteractorShopItemDetailProtocol {
    
    //MARK: - Properties & Variables
    
    //MARK: - Toggle Wishlist & Cart Items in RealM DB
    func wishListOrAddToCartItem(_ item: ListItem, addRealMObjectType: AddRealMObjectType) {
        switch addRealMObjectType {
        case .wishList:
            item.toggleWishListCompleted(realmObj: RealmProvider.default.realm)
        case .addToBag:
            item.toggleCartCompleted(realmObj: RealmProvider.default.realm)
        }
    }
}
