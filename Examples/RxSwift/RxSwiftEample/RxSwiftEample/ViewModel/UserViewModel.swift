//
//  UserViewModel.swift
//  RxSwiftEample
//
//  Created by Jyoti on 08/09/2022.
//

import Foundation
import RxRelay
import RxSwift
import RxCocoa

class UserViewModel {
    
    let request = APIRequest()
    var users : Observable<[UserDetails]>?
    private let userViewModel = BehaviorRelay<[UserDetailModel]>(value : [])
    var userViewModelObserver : Observable<[UserDetailModel]> {
        return userViewModel.asObservable()
    }
    
    private let disposeBag = DisposeBag()
    
    func fetchUserList() {
        users = request.callAPI()
        users?.subscribe(onNext : { (value) in
            var userViewModelArray = [UserDetailModel]()
            for index in 0..<value.count {
                var user = UserDetailModel()
                user.userData = value[index]
                userViewModelArray.append(user)
            }
            self.userViewModel.accept(userViewModelArray)
        }, onError : { (error) in
            _ = self.userViewModel.catch({ (error) in
                Observable.empty()
            })
            print(error.localizedDescription)
        }).disposed(by : disposeBag)
    }
}
