//
//  FMRecommendViewModel.swift
//  FM
//
//  Created by fengsong on 2020/5/6.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
class FMHomeRecommendViewModel: NSObject {
    
    // MARK - 数据模型
    var focusImages: [FMFocusImagesData]? ///轮播
    var categoryBtnList: [FMCategoryBtnModel]? ///分类
    var topBuzzList: [FMTopBuzzModel]? ///听头条
    
    var fmhomeRecommendModel:FMHomeRecommendModel?
    var homeRecommendList:[FMRecommendModel]?
    var recommendList : [FMRecommendListModel]?
    
    // Mark: -数据源更新
    typealias FMDataBlock = () -> Void
    var updataBlock:FMDataBlock?
    
    
    // 每个分区显示item数量
    func numberOfSections() -> NSInteger {
        return (self.homeRecommendList?.count) ?? 0
    }
    // 每个分区显示item数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        
        let moduleType = self.homeRecommendList?[section].moduleType
        let direction =  self.homeRecommendList?[section].direction
        switch (moduleType,direction) {
        case ("focus",_),("topBuzz",_),(_,"column"):
            return 1
        case ("square",_):
            return 0
        default:
            return self.homeRecommendList?[section].list?.count ?? 0
        }
    }
    // 高度
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        
        let moduleType = self.homeRecommendList?[indexPath.section].moduleType
        let direction =  self.homeRecommendList?[indexPath.section].direction
        switch (moduleType,direction) {
        case ("focus",_):
            return 150
        case ("square",_):
            return 80
        case ("topBuzz",_):
            let listCount = self.topBuzzList?.count ?? 0
            return CGFloat(listCount) * FMItemHeight2
        case (_,"column")://"categoriesForShort","playlist","categoriesForExplore"
            let listCount = homeRecommendList?[indexPath.section].list?.count ?? 1
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
        let headerTitle = homeRecommendList?[section].title ?? ""
        let listCount = homeRecommendList?[section].list?.count ?? 0
        if headerTitle.isEmpty {
            return 0.0
        }
        if listCount == 0 {
            return 0.0
        }
        if section == FMHomeVipSectionBanner{
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

extension FMHomeRecommendViewModel{
    
    func refreshDataSource() {
        
        FMRecommendProvider.request(.recommendList) { (result) in
            switch result{
            case .success(let response):
                do{
                    let data = try response.mapJSON()
                    let json = JSON(data)
                    printLog(message: json.description)
                    if let mappedObject = JSONDeserializer<FMHomeRecommendModel>.deserializeFrom(json: json.description) {
                        self.fmhomeRecommendModel = mappedObject
                        self.homeRecommendList = mappedObject.list
                    }
                    if let recommendList = JSONDeserializer<FMRecommendListModel>.deserializeModelArrayFrom(json: json["list"].description) {
                        self.recommendList = recommendList as? [FMRecommendListModel]
                    }
                    //Banner
                    if let focus = JSONDeserializer<FMFocusImagesModel>.deserializeFrom(json: json["list"][0]["list"][0].description) {
                        self.focusImages = focus.data
                    }
                    //分类
                    if let square = JSONDeserializer<FMCategoryBtnModel>.deserializeModelArrayFrom(json: json["list"][1]["list"].description) {
                        self.categoryBtnList = square as? [FMCategoryBtnModel]
                    }
                    //听头条
                    if let topBuzz = JSONDeserializer<FMTopBuzzModel>.deserializeModelArrayFrom(json: json["list"][2]["list"].description) {
                        self.topBuzzList = topBuzz as? [FMTopBuzzModel]
                    }
                    
                    
                    self.updataBlock?()
                    
                }catch let error{
                    printLog(message: error.localizedDescription)
                }
            case .failure(let error):
                printLog(message: error.localizedDescription)
            }
        }
    }
    
}
