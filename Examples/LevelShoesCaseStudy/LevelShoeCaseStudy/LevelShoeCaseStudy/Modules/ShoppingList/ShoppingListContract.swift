//
//  ShoppingListContract.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 16/10/2022.
//

import Foundation
import UIKit
import RealmSwift

// MARK: View Output (Presenter -> View)
protocol PresenterToViewShoppingListProtocol: AnyObject {
    func onFetchShoppingListSuccess()
    func onFetchShoppingListFailure(error: String)
    func showHUD()
    func hideHUD()
    func deselectRowAt(row: Int)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterShoppingListProtocol: AnyObject {
    var view: PresenterToViewShoppingListProtocol? { get set }
    var interactor: PresenterToInteractorShoppingListProtocol? { get set }
    var router: PresenterToRouterShoppingListProtocol? { get set }
    var shoppingListResult : ShoppingList? { get set }
    var items: Results<ListItem>? { get set }
    func viewDidLoad()
    func refresh()
    func numberOfRowsInSection() -> Int
    func didSelectRowAt(index: Int)
    func deselectRowAt(index: Int)
    func wishListItem(_ item: ListItem)
    func inValidateData()
    func pushToWishListScreen(itemType : AddRealMObjectType)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorShoppingListProtocol: AnyObject {
    var presenter: InteractorToPresenterShoppingListProtocol? { get set }
    func loadShoppingList(completion: (() -> Void)?)
    func retrieveShoppingItem(at index: Int, listItems :  Results<ListItem>?)
    func wishListItem(_ item: ListItem, completion: (() -> Void)?)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterShoppingListProtocol: AnyObject {
    
    func fetchShoppingListSuccess(shoppingListResult: ShoppingList)
    func fetchShoppingListFailure(errorMessage: String)
    func getShopItemSuccess(_ shopItem: ListItem, otherData: (currency: String, tags: String))
    func getShopItemFailure()
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterShoppingListProtocol: AnyObject {
    
    static func createModule(shoppingListVCRef : ShoppingListViewController)
    func pushToShoppingItemDetail(on view: PresenterToViewShoppingListProtocol, with list: ListItem, otherData: (currency: String, tags: String))
    func pushToWishListScreen(on view: PresenterToViewShoppingListProtocol, currency : String, itemType : AddRealMObjectType)
}

 
