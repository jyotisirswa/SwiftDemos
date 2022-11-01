//
//  WishListTableViewController.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 27/10/2022.
//

import UIKit
import RealmSwift

class WishListTableViewController: UITableViewController {

    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 300
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUI()
        guard let presenterObj = presenter else {
            return
        }
        presenterObj.viewDidLoad()
    }
    
    //MARK: - Properties
    var presenter: ViewToPresenterWishListProtocol?

    func setupUI() {
        self.tableView.register(WishListCustomCell.nib, forCellReuseIdentifier: "wishListCustomCell")
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveReloadNotification(notification:)), name:  Notification.Name("RELOAD_NOTIFICATION"), object: nil)

    }
    
    @objc func didReceiveReloadNotification(notification: NSNotification) {
        self.updateWishOrCartListTableData(wishListItem: self.presenter?.wishOrCartListItems)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: - Table view data source & delegates
extension WishListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presenter?.numberOfRowsInSection() ?? 0 == 0 {
            //self.tableView.setEmptyMessage("Your \(self.presenter?.addRealMObjectType == .wishList ? "WishList" : "CartList") is empty")
        } else {
            self.tableView.restore()
        }
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //print(cell.contentView.frame.size.height)
        cell.layoutIfNeeded()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let wishListCell = tableView.dequeueReusableCell(withIdentifier: "wishListCustomCell", for: indexPath) as? WishListCustomCell else {
            return UITableViewCell(frame: .zero)
        }
        if let listItems = presenter?.wishOrCartListItems, let currencyObj = presenter?.currency, let itemType = self.presenter?.addRealMObjectType {
            wishListCell.configureWith(listItems[indexPath.row], currency: currencyObj) { wishListItem in
                self.presenter?.removeWishOrCartListItem(wishListItem, itemType: itemType)
            }
        }
        return wishListCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension WishListTableViewController : PresenterToViewWishListProtocol {
    func setupNavBar() {
        setupNavigationBar(rightBarButtonImage: "close" , title: "\(self.presenter?.addRealMObjectType == .wishList ? "WishList" : "CartList") \(self.presenter?.numberOfRowsInSection() == 0 ? "" : "(\(self.presenter?.numberOfRowsInSection() ?? 0))")".uppercased())
    }
    func updateWishOrCartListTableData(wishListItem: Results<ListItem>?) {
        if self.tableView != nil {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.setupNavBar()
        }
    }
}

