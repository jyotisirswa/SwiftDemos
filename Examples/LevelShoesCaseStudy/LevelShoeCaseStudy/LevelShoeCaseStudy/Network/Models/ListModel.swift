//
//  ListModel.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 16/10/2022.
//

import Foundation
import RealmSwift
import UIKit

// MARK: - ShoppingList + Codable + RealM
@objcMembers class ShoppingList:  Codable {
    var title = "", currency: String = ""
    dynamic var items: [ListItem] = []
    
    private enum CodingKeys: String, CodingKey {
        case title, currency, items
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        currency = try container.decodeIfPresent(String.self, forKey: .currency) ?? ""
        items =  try container.decodeIfPresent(Array.self, forKey: .items) ?? []
    }
 
}

// MARK: - ListItem + Codable + RealM
@objcMembers class ListItem: Object, Codable {
    enum Property: String {
       case id
    }
    dynamic var id = "" , sku = "", image = "", brand = "", name : String = ""
    dynamic var price : Int = 0
    dynamic var originalPrice = RealmOptional<Int>()
    dynamic var isWishListed = false
    dynamic var isCartAdded = false
    dynamic var badges = List<String>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, sku, image, brand, name, price, originalPrice, isWishListed, isCartAdded, badges
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey:.id)
        sku = try container.decodeIfPresent(String.self, forKey: .sku) ?? ""
        image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        brand = try container.decodeIfPresent(String.self, forKey: .brand) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        price = try container.decodeIfPresent(Int.self, forKey: .price) ?? 0
        self.originalPrice.value = try container.decodeIfPresent(Int.self, forKey: .originalPrice)
        isWishListed = try container.decodeIfPresent(Bool.self, forKey: .isWishListed) ?? false
        isCartAdded = try container.decodeIfPresent(Bool.self, forKey: .isCartAdded) ?? false
        badges = try container.decodeIfPresent(List.self, forKey: .badges) ?? List<String>()
    }
}

@objcMembers class Badges: Object, Codable {
    dynamic var badgeString = ""
}

enum AddRealMObjectType : Int {
    case wishList = 1
    case addToBag = 2
}

//MARK: - Hashable + Realm Functions 
extension ListItem {
    static func == (lhs: ListItem, rhs: ListItem) -> Bool {
        guard lhs.id == rhs.id  else {
            //print("Types of lhs and rhs are not same ")
            return false
        }
        return true
    }
    
    func toggleWishListCompleted(realmObj : Realm?) {
        guard let realm = realmObj else { return  }
        try! realm.write {
            isWishListed = !isWishListed
        }
    }
    
    func toggleCartCompleted(realmObj : Realm?) {
        guard let realm = realmObj else { return }
        try! realm.write {
            isCartAdded = !isCartAdded
        }
    }
    
    static func all(in realm: Realm = try! Realm()) -> Results<ListItem> {
        print(realm.objects(ListItem.self).sorted(byKeyPath: "id", ascending: true))
        return realm.objects(ListItem.self).sorted(byKeyPath: "id", ascending: true)
    }
    
    static func wishList(in realm: Realm = try! Realm()) -> Results<ListItem> {
        return realm.objects(ListItem.self)
            .sorted(byKeyPath: "id", ascending: true).filter("isWishListed == true")
    }
    static func cartList(in realm: Realm = try! Realm()) -> Results<ListItem> {
        return realm.objects(ListItem.self)
            .sorted(byKeyPath: "id", ascending: true).filter("isCartAdded == true")
    }
}
