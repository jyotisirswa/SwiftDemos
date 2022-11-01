//
//  ShoppingItemDetailRouter.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 16/10/2022.
//

import Foundation
import UIKit

class ShoppingItemDetailRouter : PresenterToRouterShopItemDetailProtocol {
    static func createModule(with otherData: (currency: String, tags: String), shopItem: ListItem) -> UIViewController {
        print("ShoppingItemDetailRouter creates the ShoppingItemDetail module.")
        let viewController = UIStoryboard.init(name: StoryBoard.Main.rawValue, bundle: .main).instantiateViewController(withIdentifier: "ShoppingItemDetailViewController") as! ShoppingItemDetailViewController
        let presenter: ViewToPresenterShopItemDetailProtocol  = ShoppingItemDetailPresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = ShoppingItemDetailRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = ShoppingItemDetailInteractor()
        viewController.presenter?.otherData = otherData
        viewController.presenter?.shopItem = shopItem
        return viewController
    }
}

