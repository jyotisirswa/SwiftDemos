//
//  ShoppingListPresenter.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 16/10/2022.
//

import Foundation
import RealmSwift

class ShoppingListPresenter : ViewToPresenterShoppingListProtocol {

    //MARK: Properties
    weak var view: PresenterToViewShoppingListProtocol?
    var interactor: PresenterToInteractorShoppingListProtocol?
    var router: PresenterToRouterShoppingListProtocol?
    var shoppingListResult: ShoppingList? {
        didSet {
            DispatchQueue.main.async {
                (self.view as? ShoppingListViewController)?.navigationItem.title = self.shoppingListResult?.title
            }
        }
    }
    private var itemsToken: NotificationToken?
    var items: Results<ListItem>?
    
    func viewDidLoad() {
        print("Presenter is being notified that the View was loaded.")
        view?.showHUD()
        interactor?.loadShoppingList(completion: {
            print("Presenter is being notified on shoppingList api calling")
        })
        guard let shoppingVC = view as? ShoppingListViewController else {
            print("ShoppingListViewController reference is nil")
            return
        }
        items = ListItem.all()
        guard let collectionView = shoppingVC.collectionViewShoppingList else { return }
        self.itemsToken = self.items?.observe { (changes: RealmCollectionChange) in
            DispatchQueue.main.async {
                switch changes {
                case .initial:
                    print("Initial data loaded from RealM")
                    //self.view?.onFetchShoppingListSuccess()
                   // collectionView.reloadData()
                case .update(_, let deletions, let insertions, let updates):
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name("RELOAD_NOTIFICATION"), object: nil)
                        collectionView.applyChanges(deletions: deletions, insertions: insertions, updates: updates)
                        collectionView.reloadData()
                    }
                case .error: break
                }
            }
        }
    }
    
    func refresh() {
        print("Presenter is being notified that the View was refreshed.")
        self.view?.showHUD()
        interactor?.loadShoppingList(completion: {
            print("Presenter is being notified on shoppingList api calling")
        })
    }
    
    func numberOfRowsInSection() -> Int {
        guard let shoppingList = self.items else {
            return 0
        }
        return shoppingList.count
    }
    
    func didSelectRowAt(index: Int) {
        self.interactor?.retrieveShoppingItem(at: index, listItems: self.items)
    }
    
    func deselectRowAt(index: Int) {
        view?.deselectRowAt(row: index)
    }
    
    func wishListItem(_ item: ListItem) {
        self.interactor?.wishListItem(item, completion: {
            print("WishListItem toggled successfully")
        })
    }
    
    func pushToWishListScreen(itemType : AddRealMObjectType) {
        self.router?.pushToWishListScreen(on: view!, currency: self.shoppingListResult?.currency ?? "", itemType: itemType)
    }
    
    func inValidateData() {
        itemsToken?.invalidate()
    }
}

extension ShoppingListPresenter : InteractorToPresenterShoppingListProtocol {
    func fetchShoppingListSuccess(shoppingListResult: ShoppingList) {
        self.shoppingListResult = shoppingListResult
        DispatchQueue.main.async {
            self.view?.onFetchShoppingListSuccess()
            self.view?.hideHUD()
        }
    }
    
    func fetchShoppingListFailure(errorMessage: String) {
        self.view?.onFetchShoppingListFailure(error: errorMessage)
    }
    
    func getShopItemSuccess(_ shopItem: ListItem, otherData: (currency: String, tags: String)) {
        router?.pushToShoppingItemDetail(on: self.view!, with: shopItem, otherData: otherData)
    }
    
    func getShopItemFailure() {
        
    }
}
