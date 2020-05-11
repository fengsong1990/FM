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
        
        
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
//        let tabbar = setUpTabBar(delegate: self as? UITabBarControllerDelegate)
//        self.window?.rootViewController = tabbar
        
        let homeNav = setUpItem(FMHomeController(), title: "首页", imageName: "home", selectedImageName: "home_1")
        self.window?.rootViewController = homeNav
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
        let playNav = setUpItem(FMPlayController(), title: nil, imageName: "tab_play", selectedImageName: "tab_play" ,contentView: FMIrregularityBarItemContentView())
        let findNav = setUpItem(FMFindController(), title: "发现", imageName: "favor", selectedImageName: "favor_1")
        let mineNav = setUpItem(FMMineController(), title: "我的", imageName: "me", selectedImageName: "me_1")
        tabBarController.viewControllers = [homeNav, listenNav, playNav, findNav, mineNav]
        return tabBarController
        
    }
    ///2、构建模块
    private  func setUpItem(_ itemVC:UIViewController, title: String? = nil, imageName: String, selectedImageName: String ,contentView: ESTabBarItemContentView = FMBasicBarItemContentView()) -> FMNavigationController{
        
        itemVC.title = title
        itemVC.tabBarItem = ESTabBarItem.init(contentView, title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        let vcNav = FMNavigationController.init(rootViewController: itemVC)
        return vcNav;
        
    }
    
    func printLog<T>(message: T,file: String = #file,method: String = #function,line: Int = #line){
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    }

}


