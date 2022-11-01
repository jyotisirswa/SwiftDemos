//
//  ShoppingListContract.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 16/10/2022.
//

import Foundation
import UIKit

//MARK: View Output (Presenter -> View)
protocol PresenterToViewShopItemDetailProtocol: AnyObject {
    func updateShopDetailsData(shopItem : ListItem?)
}

//MARK: View Input (View -> Presenter)
protocol ViewToPresenterShopItemDetailProtocol: AnyObject {
    var view: PresenterToViewShopItemDetailProtocol? { get set }
    var interactor: PresenterToInteractorShopItemDetailProtocol? { get set }
    var router: PresenterToRouterShopItemDetailProtocol? { get set }
    var shopItem : ListItem?  { get set }
    var otherData: (currency : String?, tags : String?) {get set}
    func viewDidLoad()
    func wishListOrAddToCartItem(_ item: ListItem, addRealMObjectType : AddRealMObjectType)
}

//MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorShopItemDetailProtocol: AnyObject {

    func wishListOrAddToCartItem(_ item: ListItem, addRealMObjectType : AddRealMObjectType)

}

//MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterShopItemDetailProtocol: AnyObject {
}

//MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterShopItemDetailProtocol: AnyObject {
    static func createModule(with otherData : (currency : String, tags : String), shopItem : ListItem) -> UIViewController
}

