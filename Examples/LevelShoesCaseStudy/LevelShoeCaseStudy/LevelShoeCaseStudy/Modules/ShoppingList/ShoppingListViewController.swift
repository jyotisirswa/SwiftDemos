//
//  ShoppingListViewController.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 16/10/2022.
//


import UIKit
import RealmSwift

class ShoppingListViewController: UIViewController {

    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view.
        self.setupUI()
        ShoppingListRouter.createModule(shoppingListVCRef: self)
        guard let presenterObj = presenter else {
            return
        }
        presenterObj.viewDidLoad()

    }
    //MARK: - Properties
    var presenter: ViewToPresenterShoppingListProtocol?
    @IBOutlet weak var collectionViewShoppingList: UICollectionView!
    var dynamicCell = (maxHeight : 0, indexPath : IndexPath.init(item: 0, section: 0))

    let loadingIndicator: ProgressView = {
        let progress = ProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    //MARK: - Actions
    func setupUI() {
        collectionViewShoppingList.register(ShoppingListCollectionCell.nib, forCellWithReuseIdentifier: "shoppingListCollectionCell")
        collectionViewShoppingList?.backgroundColor = .clear
        collectionViewShoppingList?.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 16)
        collectionViewShoppingList.delegate = self
        collectionViewShoppingList.dataSource = self
        collectionViewShoppingList.reloadData()
    }
    
    @IBAction private func buttonWishListTapped(_ sender: UIBarButtonItem) {
        self.presenter?.pushToWishListScreen(itemType: .wishList)
    }
    
    @IBAction func buttonCartListTapped(_ sender: UIBarButtonItem) {
        self.presenter?.pushToWishListScreen(itemType: .addToBag)
    }
    
    deinit {
        self.presenter?.inValidateData()
    }
}

extension ShoppingListViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let shoppingListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "shoppingListCollectionCell", for: indexPath) as? ShoppingListCollectionCell else {
            return UICollectionViewCell(frame: .zero)
        }
        if let listItems = self.presenter?.items , let currencyObj = self.presenter?.shoppingListResult?.currency {
            shoppingListCell.currency = currencyObj
            shoppingListCell.shoppingItem = listItems[indexPath.item]
            shoppingListCell.onWishListCompleted = { [weak self] currentCell in
                guard let cellIndexPath = self?.collectionViewShoppingList.indexPath(for: currentCell) else {
                    return
                }
                print("button pressed",cellIndexPath)
                print(listItems[cellIndexPath.item])
                self?.presenter?.wishListItem(listItems[cellIndexPath.item])
            }
        }
        return shoppingListCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? ShoppingListCollectionCell {
            let height = cell.labelName.getHeight
            checkMax(height: Int(height), forItemAt: indexPath)
        } else {
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.didSelectRowAt(index: indexPath.item)
        self.presenter?.deselectRowAt(index: indexPath.row)
    }
}

extension ShoppingListViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 4)) / 2
        //let dynamicHeight  = Int(dynamicCell.maxHeight) + Int(deviceHeight * 0.393064)
        //let defaultHeight = Int(deviceHeight * 0.444)
        let h =  dynamicCell.maxHeight == 0 ? 304  : dynamicCell.maxHeight + 276
        return CGSize.init(width: itemSize, height: CGFloat(h))
    }
}


extension ShoppingListViewController : PresenterToViewShoppingListProtocol {
    func onFetchShoppingListSuccess() {
        collectionViewShoppingList.invalidateIntrinsicContentSize()
        DispatchQueue.main.async {
            self.navigationItem.title = self.presenter?.shoppingListResult?.title
            self.collectionViewShoppingList.reloadData()
            self.collectionViewShoppingList.layoutIfNeeded()
            self.collectionViewShoppingList.isHidden = false
        }
    }
    
    func onFetchShoppingListFailure(error: String) {
        //print("View receives the response from Presenter with error: \(error)")
        DispatchQueue.main.async {
            if self.loadingIndicator.isAnimating {
                self.loadingIndicator.isAnimating = false
                self.presentAlertWithTitleAndMessage(title: "Hello User!", message: error, options: "Ok") { (option) in
                    //Dismiss the alert
                }
            }
        }
    }
    
    func showHUD() {
        DispatchQueue.main.async {
            self.view.addSubview(self.loadingIndicator)
            self.view.bringSubviewToFront(self.loadingIndicator)
            self.setupPositionOfProgressView(loadingIndicator: self.loadingIndicator)
            self.loadingIndicator.isAnimating = true
        }
    }
    
    func hideHUD() {
        DispatchQueue.main.async {
            //self.setupPositionOfProgressView(loadingIndicator: self.loadingIndicator)
            self.loadingIndicator.isAnimating = false
        }
    }
    
    func deselectRowAt(row: Int) {
        self.collectionViewShoppingList.deselectItem(at: IndexPath(item: row, section: 0), animated: false)
    }
    
    func newMax(){
        DispatchQueue.main.async {
            self.collectionViewShoppingList.reloadItems(at: [ self.dynamicCell.indexPath])
        }
    }
    
    func checkMax(height: Int, forItemAt indexPath: IndexPath ) {
        let newMax = height > dynamicCell.maxHeight ? height: dynamicCell.maxHeight
        if(newMax != dynamicCell.maxHeight) {
            dynamicCell.maxHeight = newMax
            self.newMax()
            dynamicCell.indexPath = indexPath
        }
    }
}
