//
//  FMHomeController.swift
//  FM
//
//  Created by fengsong on 2020/4/27.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit
import DNSPageView
class FMHomeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setUpPageVC()
    }
    
    private func setUpPageVC(){
        //V1.2.1
        let style = PageStyle()
        style.isTitleScaleEnabled = true
        style.isShowBottomLine = true
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = FMButtonColor
        style.bottomLineHeight = 2
        
        let titles = ["推荐","分类","VIP","直播","广播"]
        let viewControllers:[UIViewController] = [FMHomeRecommendController(),FMHomeClassifyController(),FMHomeVIPController(),FMHomeLiveController(),FMHomeBroadcastController()]
        for vc in viewControllers{
            addChild(vc)
        }
        let rect = CGRect.init(x: 0, y: FMNavBarHeight, width: FMScreenWidth, height: FMScreenHeight-FMNavBarHeight)
        let pageView = PageView.init(frame: rect, style: style, titles: titles, childViewControllers: viewControllers)
        pageView.contentView.backgroundColor = UIColor.red
        view.addSubview(pageView)
    }
    
}
