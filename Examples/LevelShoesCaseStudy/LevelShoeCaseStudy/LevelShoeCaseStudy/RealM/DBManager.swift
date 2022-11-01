////
////  DBManager.swift
////  LevelShoeCaseStudy
////
////  Created by Jyoti on 19/10/2022.
////
//
//import RealmSwift
//import UIKit
//
//class DBManager {
//    private var database:Realm
//    static let sharedInstance = DBManager()
//
//    private init() {
//        database = try! Realm()
//    }
//
//    func getDataFromDB() -> Results<ShopItem> {
//        let results: Results<ShopItem> = database.objects(ShopItem.self)
//        return results
//    }
//
//    func addData(object: ShopItem) {
//        try! database.write {
//            database.add(object)
//            //print("Added new object")
//        }
//    }
//
//    func deleteAllDatabase()  {
//        try! database.write {
//            database.deleteAll()
//        }
//    }
//
//    func deleteFromDb(object: ShopItem) {
//        try! database.write {
//            database.delete(object)
//        }
//    }
//
//}
//
//class ShopItem: Object {
//    dynamic var id = ""
//    override static func primaryKey() -> String? {
//        return "id"
//    }
//}
//
