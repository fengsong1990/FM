//
//  FMPlayViewModel.swift
//  FM
//
//  Created by fengsong on 2020/5/11.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class FMPlayViewModel: NSObject {

    // 外部传值请求接口如此那
    var albumId :Int = 0
    var trackUid:Int = 0
    var uid:Int = 0
    convenience init(albumId: Int = 0, trackUid: Int = 0,uid:Int = 0) {
        self.init()
        self.albumId = albumId
        self.trackUid = trackUid
        self.uid = uid
    }
    
    static let share = FMPlayViewModel()
    
     var playDetailAlbum:FMPlayDetailAlbumModel?
     var playDetailUser:FMPlayDetailUserModel?
     var playDetailTracks:FMPlayDetailTracksModel?
    
     // Mark: -数据源更新
     typealias FMDataBlock = () -> Void
     var playDetailDataBlock:FMDataBlock? //播放详情页面数据回调
     var playBlock:FMDataBlock? //播放页面回调
    //play
    var playTrackInfo:FMPlayTrackInfo?
    var playCommentInfo:[FMPlayCommentInfo]?
    var userInfo:FMPlayUserInfo?
    var communityInfo:FMPlayCommunityInfo?
}

extension FMPlayViewModel{
    ///播放页数据
    func getPlayDetailData(albumId:Int,pageIndex:Int = 1){
        self.albumId = albumId
        FMPlayProvider.request(FMPlayApi.playDetailData(albumId: albumId,pageIndex:pageIndex)) { (result) in
            
            switch result{
            case .success(let response):
                do{
                    // 解析数据
                    let data = try response.mapJSON()
                    let json = JSON(data)
                    printLog(message: json.description)
                    // 从字符串转换为对象实例
                    if let playDetailAlbum = JSONDeserializer<FMPlayDetailAlbumModel>.deserializeFrom(json: json["data"]["album"].description) {
                        self.playDetailAlbum = playDetailAlbum
                    }
                    // 从字符串转换为对象实例
                    if let playDetailUser = JSONDeserializer<FMPlayDetailUserModel>.deserializeFrom(json: json["data"]["user"].description) {
                        self.playDetailUser = playDetailUser
                    }
                    // 从字符串转换为对象实例
                    if let playDetailTracks = JSONDeserializer<FMPlayDetailTracksModel>.deserializeFrom(json: json["data"]["tracks"].description) {
                        self.playDetailTracks = playDetailTracks
                    }
                    
                    
                    self.playDetailDataBlock?()
                    
                    
                }catch let error{
                    printLog(message: error.localizedDescription)
                }
            case .failure(let error):
                printLog(message: error.localizedDescription)
            }
        }
    }
    
    //播放数据
    func getPlayDataDataSource(){
        FMPlayProvider.request(FMPlayApi.fmPlayData(albumId: self.albumId, trackUid: self.trackUid, uid: self.uid)) { (result) in
            switch result{
            case .success(let response):
                do{
                    let data = try response.mapJSON()
                    let json = JSON(data)
                    printLog(message: json.description)
                    
                    // 从字符串转换为对象实例
                    if let playTrackInfo = JSONDeserializer<FMPlayTrackInfo>.deserializeFrom(json: json["trackInfo"].description) {
                        self.playTrackInfo = playTrackInfo
                    }
                    // 从字符串转换为对象实例
                    if let commentInfo = JSONDeserializer<FMPlayCommentInfoList>.deserializeFrom(json: json["noCacheInfo"]["commentInfo"].description) {
                        self.playCommentInfo = commentInfo.list
                    }
                    // 从字符串转换为对象实例
                    if let userInfoData = JSONDeserializer<FMPlayUserInfo>.deserializeFrom(json: json["userInfo"].description) {
                        self.userInfo = userInfoData
                    }
                    // 从字符串转换为对象实例
                    if let communityInfoData = JSONDeserializer<FMPlayCommunityInfo>.deserializeFrom(json: json["noCacheInfo"]["communityInfo"].description) {
                        self.communityInfo = communityInfoData
                    }
                    self.playBlock?()
                     
                }catch let error{
                    printLog(message: error.localizedDescription)
                }
            case .failure(let error):
                printLog(message: error.localizedDescription)
            }
        }
        
    }
}
