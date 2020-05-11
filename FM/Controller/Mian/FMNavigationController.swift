//
//  FMNavigationController.swift
//  FM
//
//  Created by fengsong on 2020/4/28.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit

class FMNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupNavBarAppearence()
    }
    
    private func setupNavBarAppearence(){
        // 设置导航栏默认的背景颜色
        WRNavigationBar.defaultNavBarBarTintColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        // 设置导航栏所有按钮的
        WRNavigationBar.defaultNavBarTintColor = FMButtonColor
        WRNavigationBar.defaultNavBarTitleColor = UIColor.black
        // 统一设置导航栏样式
        //WRNavigationBar.defaultStatusBarStyle = .lightContent
        // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
        WRNavigationBar.defaultShadowImageHidden = true
    }
}

extension FMNavigationController{
    
    func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        return true
    }
    //防止返回的时候奔溃
    override func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        return true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
