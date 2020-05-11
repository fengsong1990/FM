//
//  HomeVIPViewModel.swift
//  FM
//
//  Created by fengsong on 2020/4/29.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON


class FMHomeVIPViewModel: NSObject {
    
    var focusImages: [FMFocusImagesData]?
    var categoryBtnList: [FMCategoryBtnModel]?
    
    var categoryList:[FMCategoryList]?
    var homevipData :FMHomeVIPModel?
    
    // Mark: -数据源更新
    typealias FMDataBlock = () -> Void
    var updataBlock:FMDataBlock?
    
    
    // 每个分区显示item数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
          switch section {
          case FMHomeVipSectionVip:
              return self.categoryList?[section].list?.count ?? 0
          default:
              return 1
          }
      }
    // 高度
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case FMHomeVipSectionBanner:
            return 150
        case FMHomeVipSectionGrid:
            return 80
        case FMHomeVipSectionHot,FMHomeVipSectionEnjoy:
            let listCount = categoryList?[indexPath.section].list?.count ?? 1
            if listCount%3 == 0 {
                return FMItemHeight * CGFloat(listCount/3) + FMItemMinSpace * CGFloat(listCount/3 - 1)
            }
            return FMItemHeight * CGFloat(listCount/3 + 1) + FMItemMinSpace * CGFloat(listCount/3)
        default:
            return 120
        }
    }
    // header高度
    func heightForHeaderInSection(section:Int) ->CGFloat {
        if section == FMHomeVipSectionBanner || section == FMHomeVipSectionGrid {
            return 0.0
        }else {
            return 50
        }
    }
    
    // footer 高度
    func heightForFooterInSection(section:Int) ->CGFloat {
        if section == FMHomeVipSectionBanner {
            return 0.0
        }else {
            return 10
        }
    }
    
    
    
    
}

extension FMHomeVIPViewModel{
    
    func refreshDataSource() {
        // 首页vip接口请求
        FMHomeVIPApiProvider.request(FMHomeVIPApi.homeVipList) { (result) in
            switch result{
            case .success(let response):
                do{
                    let data = try response.mapJSON()
                    let json = JSON(data)
                    printLog(message: json.description)
                    if let mappedObject = JSONDeserializer<FMHomeVIPModel>.deserializeFrom(json: json.description) {
                        self.homevipData = mappedObject
                        self.focusImages = mappedObject.focusImages?.data
                        self.categoryList = mappedObject.categoryContents?.list
                    }
                    if let categorybtn = JSONDeserializer<FMCategoryBtnModel>.deserializeModelArrayFrom(json:json["categoryContents"]["list"][0]["list"].description){
                        self.categoryBtnList = categorybtn as? [FMCategoryBtnModel]
                    }
                    self.updataBlock?()
                }catch let error{
                    printLog(message: error.localizedDescription)
                }
                self.updataBlock?()
                
            case .failure(let error):
                printLog(message: error.localizedDescription)
            }
        }
    }
    
    
}
