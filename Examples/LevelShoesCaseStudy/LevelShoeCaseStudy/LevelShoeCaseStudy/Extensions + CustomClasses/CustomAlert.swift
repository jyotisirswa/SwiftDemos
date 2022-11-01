//
//  CustomAlert.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 01/11/2022.
//

import Foundation
import UIKit


struct Alert {
    
    private static func showAlert(on vc:UIViewController,with title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
//    //Show Common Alert like internet failure
//    static func showInternetFailureAlert(on vc:UIViewController){
//        showAlert(on: vc, with: internetAlertTitle, message: internetAlertMessage)
//    }
    
}


