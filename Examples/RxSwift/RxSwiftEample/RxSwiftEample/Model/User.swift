//  User.swift
//  RxSwiftEample
//  Created by Jyoti on 08/09/2022.
//

import Foundation
import RxSwift
import RxRelay

struct DataModel : Codable {
    let page : Int?
    let per_page : Int?
    let total : Int?
    let total_page : Int?
    let data : [UserDetails]?
}

struct UserDetails : Codable {
    let id : Int?
    let email : String?
    let First_name : String?
    let last_name : String?
    let avatar : String?
}

struct UserDetailModel {
    var userData = UserDetails(id: 1, email: "joy@yopmail.com", First_name: "Joy", last_name: "Sirswa", avatar: "avatar")
    var isFavorite : BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var isFavObservable : Observable<Bool> {
        return isFavorite.asObservable()
    }
}
