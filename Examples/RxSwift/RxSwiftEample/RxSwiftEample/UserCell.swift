//
//  UserCell.swift
//  RxSwiftEample
//
//  Created by Jyoti on 08/09/2022.
//

import UIKit

class UserCell: UITableViewCell {
    
    //Properties & Variables
    static let starTintColor = UIColor(red: 212/255, green: 163/255, blue: 50/255, alpha: 1.0)
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(userDetail : UserDetailModel) {
        userName.text = userDetail.userData.First_name ?? ""
        if userDetail.isFavorite.value {
            favoriteImage.image = UIImage(systemName: "star.fill")?.withTintColor(UserCell.starTintColor)
        } else {
            favoriteImage.image = UIImage(systemName: "star")?.withTintColor(UserCell.starTintColor)
        }
    }

}
