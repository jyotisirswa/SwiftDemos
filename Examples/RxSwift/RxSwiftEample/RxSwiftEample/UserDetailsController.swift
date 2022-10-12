//
//  UserDetailsController.swift
//  RxSwiftEample
//
//  Created by Jyoti on 08/09/2022.
//

import UIKit
import RxSwift
import RxCocoa

class UserDetailsController: UIViewController {
    
    @IBOutlet weak var idNo: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private let disposeBag = DisposeBag()
    var userDetail = BehaviorRelay<UserDetailModel>(value: UserDetailModel())
    var userDetailObserver: Observable<UserDetailModel> {
        return userDetail.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Bind button tap via rx
        favoriteButton.rx.tap.bind {
           let favValue =
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func setupFavoriteButtonImage(userValue: UserDetailModel) {
        if userValue.isFavorite.value {
            favoriteButton.setImage(UIImage(systemName: "star.fill")?.withTintColor(UserCell.starTintColor), for: .normal)
        } else{
            favoriteButton.setImage(UIImage(systemName: "star")?.withTintColor(UserCell.starTintColor), for: .normal)
        }
    }
    
}
