//
//  ShoppingListRouter.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 16/10/2022.
//

import Foundation
import UIKit

class ShoppingListRouter : PresenterToRouterShoppingListProtocol {

    static func createModule(shoppingListVCRef: ShoppingListViewController)  {
        print("ShoppingListRouter creates the Shopping module.")
        let presenter: ViewToPresenterShoppingListProtocol & InteractorToPresenterShoppingListProtocol = ShoppingListPresenter()
        shoppingListVCRef.presenter = presenter
        shoppingListVCRef.presenter?.router = ShoppingListRouter()
        shoppingListVCRef.presenter?.view = shoppingListVCRef
        shoppingListVCRef.presenter?.interactor = ShoppingListInteractor(service: ListService())
        shoppingListVCRef.presenter?.interactor?.presenter = presenter
    }
    
    func pushToShoppingItemDetail(on view: PresenterToViewShoppingListProtocol, with list: ListItem, otherData: (currency: String, tags: String)) {
        print("ShoppingListRouter is instructed to push ShoppingItemDetailViewController onto the navigation stack.")
        let shoppingItemDetailsViewController = ShoppingItemDetailRouter.createModule(with: otherData, shopItem: list)
        let viewController = view as! ShoppingListViewController
        viewController.navigationController?
            .pushViewController(shoppingItemDetailsViewController, animated: true)
    }
    
    func pushToWishListScreen(on view: PresenterToViewShoppingListProtocol, currency: String, itemType : AddRealMObjectType) {
        print("ShoppingListRouter is instructed to push WishListTableViewController onto the navigation stack.")
        let wishListVC = WishListRouter.createModule(currency: currency, itemType: itemType)
        wishListVC.isModalInPresentation = true
        let navController = UINavigationController(rootViewController: wishListVC)
        let viewController = view as! ShoppingListViewController
        viewController.navigationController?.present(navController, animated: true, completion: nil)
    }
}
