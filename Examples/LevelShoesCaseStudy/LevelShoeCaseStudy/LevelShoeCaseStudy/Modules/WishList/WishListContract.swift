//
//  WishListContract.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 27/10/2022.
//

import Foundation
import RealmSwift
import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewWishListProtocol: AnyObject {
    func updateWishOrCartListTableData(wishListItem : Results<ListItem>?)
    func setupNavBar()
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterWishListProtocol: AnyObject {
    var view: PresenterToViewWishListProtocol? { get set }
    var interactor: PresenterToInteractorWishListProtocol? { get set }
    var router: PresenterToRouterWishListProtocol? { get set }
    var wishOrCartListItems: Results<ListItem>? { get set }
    var currency : String? {get set}
    var addRealMObjectType : AddRealMObjectType { get set }
    func viewDidLoad()
    func refresh()
    func numberOfRowsInSection() -> Int
    func removeWishOrCartListItem(_ item: ListItem, itemType : AddRealMObjectType)
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorWishListProtocol: AnyObject {
    var presenter: InteractorToPresenterWishListProtocol? { get set }
    func loadWishOrCartList(itemType : AddRealMObjectType, completion: (() -> Void)?)
    func retrieveShoppingItem(at index: Int)
    func removeWishOrCartListItem(_ item: ListItem, itemType : AddRealMObjectType, completion: (() -> Void)?)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterWishListProtocol: AnyObject {
    func fetchWishOrCartListSuccess(itemType : AddRealMObjectType, listResult: Results<ListItem>?)
    func fetchWishOrCartListFailure(itemType : AddRealMObjectType, errorMessage: String)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterWishListProtocol: AnyObject {
    static func createModule(currency : String, itemType : AddRealMObjectType) -> UIViewController
    func pushToShoppingItemDetail(on view: PresenterToViewWishListProtocol, with list: ListItem, otherData : (currency : String, tags : String))
}
