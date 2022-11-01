//
//  WishListInteractor.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 27/10/2022.
//

import Foundation
import RealmSwift

class WishListInteractor : PresenterToInteractorWishListProtocol {

    weak var presenter: InteractorToPresenterWishListProtocol?
    private lazy var wishOrCartListArray =  ListItem.wishList()
    
    func loadWishOrCartList(itemType: AddRealMObjectType, completion: (() -> Void)?) {
        wishOrCartListArray = itemType ==  .wishList ? ListItem.wishList() : ListItem.cartList()
        guard wishOrCartListArray.count > 0 else {
            self.presenter?.fetchWishOrCartListFailure(itemType: itemType, errorMessage: "Your \(itemType == .wishList ? "WishList" : "Cart") is empty")
            completion?()
            return
        }
        self.presenter?.fetchWishOrCartListSuccess(itemType: itemType, listResult: wishOrCartListArray)
        completion?()
    }
    
    func retrieveShoppingItem(at index: Int) {
        guard wishOrCartListArray.indices.contains(index) else {
            return
        }
    }
    
    func removeWishOrCartListItem(_ item: ListItem, itemType: AddRealMObjectType, completion: (() -> Void)?) {
        itemType == .wishList  ? item.toggleWishListCompleted(realmObj: RealmProvider.default.realm) : item.toggleCartCompleted(realmObj: RealmProvider.default.realm)
        completion?()
        //self.presenter?.fetchWishOrCartListSuccess(itemType: itemType, listResult: itemType == .wishList ? ListItem.wishList() : ListItem.cartList() )
    }
}
