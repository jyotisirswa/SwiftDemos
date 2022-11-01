//
//  ShoppingListInteractor.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 16/10/2022.
//

import Foundation
import RealmSwift

class ShoppingListInteractor : PresenterToInteractorShoppingListProtocol {

    weak var presenter: InteractorToPresenterShoppingListProtocol?
    private var service: ListServiceable?
    private var shoppingListResult: ShoppingList?
    
    init(service: ListServiceable) {
        self.service = service
    }
    
    private func fetchData(completion: @escaping (Result<ShoppingList, RequestError>) -> Void) {
        Task(priority: .background) {
            let result = await service?.getItemList()
            completion(result!)
        }
    }
    
    func loadShoppingList(completion: (() -> Void)?) {
        Task(priority: .background) {
            fetchData { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    self.shoppingListResult = response
                    self.presenter?.fetchShoppingListSuccess(shoppingListResult: self.shoppingListResult!)
                    completion?()
                case .failure(let error):
                    self.presenter?.fetchShoppingListFailure(errorMessage: error.customMessage)
                    completion?()
                }
            }
        }
    }
    
    func retrieveShoppingItem(at index: Int, listItems :  Results<ListItem>?) {
        guard let shopItems = listItems , shopItems.indices.contains(index) else {
            print("Shop Item does not exist in list")
            self.presenter?.getShopItemFailure()
            return
        }
        print(shopItems[index])
        self.presenter?.getShopItemSuccess(shopItems[index], otherData: (currency: self.shoppingListResult?.currency ?? "", tags: self.shoppingListResult?.title ?? ""))
    }
    
    func wishListItem(_ item: ListItem, completion: (() -> Void)?) {
        //print(item)
        item.toggleWishListCompleted(realmObj: RealmProvider.default.realm)
    }
}
