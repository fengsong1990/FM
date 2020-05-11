//
//  FMHeader.swift
//  FM
//
//  Created by fengsong on 2020/4/28.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit
import SwiftyJSON
import HandyJSON


let FMScreenWidth = UIScreen.main.bounds.size.width
let FMScreenHeight = UIScreen.main.bounds.size.height

let FMButtonColor = UIColor(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let FMDownColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)

// iphone X
//let isIphoneX = FMScreenHeight == 812 ? true : false
let isIphoneX = (UIApplication.shared.statusBarFrame.size.height > 20) ? true : false
let FMNavBarHeight : CGFloat = isIphoneX ? 88 : 64
let FMTabBarHeight : CGFloat = isIphoneX ? 49 + 34 : 49

let FMItemHeight   : CGFloat = 190.0
let FMItemHeight2   : CGFloat = 60.0
let FMItemMinSpace : CGFloat = 5.0
///格式化打印信息
func printLog<T>(message: T,file: String = #file,method: String = #function,line: Int = #line){
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
}
