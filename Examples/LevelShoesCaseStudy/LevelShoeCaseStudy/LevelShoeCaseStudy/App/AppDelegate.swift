//
//  AppDelegate.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 16/10/2022.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    class func appDelegate() -> AppDelegate {
        return (UIApplication.shared.delegate! as? AppDelegate)!
    }
}

extension UIApplication {
    
    var keyWindowPresentedController: UIViewController? {
        //var viewController = UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return nil
        }

        guard let firstWindow = firstScene.windows.first else {
            return nil
        }
        var viewController = firstWindow.rootViewController
        // If root `UIViewController` is a `UITabBarController`
        if let presentedController = viewController as? UITabBarController {
            // Move to selected `UIViewController`
            viewController = presentedController.selectedViewController
        }
        
        // Go deeper to find the last presented `UIViewController`
        while let presentedController = viewController?.presentedViewController {
            // If root `UIViewController` is a `UITabBarController`
            if let presentedController = presentedController as? UITabBarController {
                // Move to selected `UIViewController`
                viewController = presentedController.selectedViewController
            } else {
                // Otherwise, go deeper
                viewController = presentedController
            }
        }
        
        return viewController
    }
}

//let deviceWidth = UIScreen.main.bounds.width
let deviceHeight = UIScreen.main.bounds.height
//let testDeviceAspectRatio = deviceHeight / deviceWidth
//
