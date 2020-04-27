//
//  AppDelegate.swift
//  FM
//
//  Created by fengsong on 2020/4/27.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit
import ESTabBarController_swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let tabbar = setUpTabBar(delegate: self as? UITabBarControllerDelegate)
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = tabbar
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    ///1.加载tabbar样式
    private func setUpTabBar(delegate:UITabBarControllerDelegate?) -> ESTabBarController {
        let tabBarController = ESTabBarController()
        tabBarController.delegate = delegate
        tabBarController.title = "FM"
        //tabBarController.tabBar.shadowImage = UIImage(named: "transparent")
        
        let homeNav = setUpItem(FMHomeController(), title: "首页", imageName: "home", selectedImageName: "home_1")
        let listenNav = setUpItem(FMListenController(), title: "我听", imageName: "find", selectedImageName: "find_1")
        let playNav = setUpItem(FMPlayController(), title: nil, imageName: "tab_play", selectedImageName: "tab_play")
        let findNav = setUpItem(FMFindController(), title: "发现", imageName: "favor", selectedImageName: "favor_1")
        let mineNav = setUpItem(FMMineController(), title: "我的", imageName: "home", selectedImageName: "me_1")
        tabBarController.viewControllers = [homeNav, listenNav, playNav, findNav, mineNav]
        return tabBarController
        
    }
    ///2、构建模块
    private  func setUpItem(_ itemVC:UIViewController, title: String? = nil, imageName: String, selectedImageName: String) -> UINavigationController{
        
        itemVC.title = title
        itemVC.tabBarItem = ESTabBarItem.init(FMBasicBarItemContentView(), title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        let vcNav = UINavigationController.init(rootViewController: itemVC)
        return vcNav;
    }
    
}


