//
//  AppDelegate.swift
//  Exhibition
//
//  Created by Bedirhan Yıldız on 1.08.2023.
//

import UIKit
import SDWebImage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let apiManager = APIManager()
        let repo = ProductListRepository(apiManager: apiManager)
        let vm = ProductListViewModel(repo: repo)
        let vc = ProductListViewController(viewModel: vm)
        let navViewController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navViewController
        window?.makeKeyAndVisible()
        return true
    }
}
