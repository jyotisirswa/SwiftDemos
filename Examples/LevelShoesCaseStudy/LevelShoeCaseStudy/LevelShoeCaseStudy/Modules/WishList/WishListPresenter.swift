//
//  WishListPresenter.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 27/10/2022.
//

import Foundation
import RealmSwift

class WishListPresenter : ViewToPresenterWishListProtocol {

    weak var view: PresenterToViewWishListProtocol?
    var interactor: PresenterToInteractorWishListProtocol?
    var router: PresenterToRouterWishListProtocol?
    var wishOrCartListItems: Results<ListItem>? {
        didSet {
            wishOrCartListItems = addRealMObjectType ==  .wishList ? ListItem.wishList() : ListItem.cartList()
        }
    }
    var currency: String?
    var addRealMObjectType: AddRealMObjectType = .wishList

    func viewDidLoad() {
        //print("Presenter is being notified that the WishListView was loaded.")
        interactor?.loadWishOrCartList(itemType: addRealMObjectType, completion: {
            print("Presenter is being notified on \(self.addRealMObjectType == .wishList ? "WishList" : "CartList") data loaded")
        })
    }
    
    func refresh() {
        
    }
    
    func numberOfRowsInSection() -> Int {
        guard let wishList = self.wishOrCartListItems?.count else {
            return 0
        }
        return wishList
    }
    
    func removeWishOrCartListItem(_ item: ListItem, itemType: AddRealMObjectType) {
        self.interactor?.removeWishOrCartListItem(item, itemType: itemType, completion:  {
            print("\(self.addRealMObjectType == .wishList ? "WishList" : "CartList") item removed successfully")
        })
    }
}

extension WishListPresenter : InteractorToPresenterWishListProtocol {
    func fetchWishOrCartListSuccess(itemType: AddRealMObjectType, listResult: Results<ListItem>?) {
        self.wishOrCartListItems = listResult
        DispatchQueue.main.async {
            self.view?.updateWishOrCartListTableData(wishListItem: self.wishOrCartListItems)
        }
    }
    
    func fetchWishOrCartListFailure(itemType: AddRealMObjectType, errorMessage: String) {
        self.view?.setupNavBar()
    }
}
