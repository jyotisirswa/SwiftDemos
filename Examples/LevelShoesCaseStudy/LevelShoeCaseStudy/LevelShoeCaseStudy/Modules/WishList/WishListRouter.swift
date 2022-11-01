//
//  WishListRouter.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 27/10/2022.
//

import Foundation
import UIKit
import RealmSwift

class WishListRouter : PresenterToRouterWishListProtocol {
    static func createModule(currency: String,itemType : AddRealMObjectType ) -> UIViewController {
        print("WishListRouter creates the WishList module.")
        let viewController = UIStoryboard.init(name: StoryBoard.Main.rawValue, bundle: .main).instantiateViewController(withIdentifier: "wishListTableViewController") as! WishListTableViewController
        let presenter: ViewToPresenterWishListProtocol & InteractorToPresenterWishListProtocol = WishListPresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = WishListRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = WishListInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        viewController.presenter?.addRealMObjectType = itemType
        viewController.presenter?.currency = currency
        return viewController
    }
    
    func pushToShoppingItemDetail(on view: PresenterToViewWishListProtocol, with list: ListItem, otherData : (currency : String, tags : String)) {
        print("WishListRouter is instructed to push ShoppingItemDetailViewController onto the navigation stack.")
        let shoppingItemDetailsViewController = ShoppingItemDetailRouter.createModule(with: otherData, shopItem: list)
        let viewController = view as! WishListTableViewController
        viewController.navigationController?
            .pushViewController(shoppingItemDetailsViewController, animated: true)
    }
}


