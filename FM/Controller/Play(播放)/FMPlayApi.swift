//
//  FMPlayApi.swift
//  FM
//
//  Created by fengsong on 2020/5/11.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit
import Moya

let FMPlayProvider = MoyaProvider<FMPlayApi>()

enum FMPlayApi {
    case fmPlayData(albumId:Int,trackUid:Int, uid:Int)
    case playDetailData(albumId:Int)//播放页数据
    
}

extension FMPlayApi: TargetType {
    var baseURL: URL {
        switch self {
        case .playDetailData,.fmPlayData:
            return URL(string: "http://mobile.ximalaya.com")!
        }
        
    }
    
    var path: String {
        switch self {
        case .fmPlayData(let albumId, let trackUid, let uid):
            return "/mobile/track/v2/playpage/\(trackUid)"
        case .playDetailData(let albumId):
            return "/mobile/v1/album/ts-1534832680180"
        }
    }
    
    var method: Moya.Method { return .get }
    
    var task: Task {
        var parmeters:[String:Any] = [:]
        switch self {
        case .fmPlayData(let albumId, let trackUid, let uid):
            parmeters = [
            "device":"iPhone",
            "operator":3,
            "scale":3,
            "appid":0,
            "ac":"WIFI",
            "network":"WIFI",
            "version":"6.5.3",
            "uid":124057809,
            "xt": Int32(Date().timeIntervalSince1970),
            "deviceId": UIDevice.current.identifierForVendor!.uuidString] as [String : Any]
            parmeters["albumId"] = albumId
            parmeters["trackUid"] = uid
            //parmeters["trackUid"] = trackUid
        case .playDetailData(let albumId):
            parmeters = [
                "device":"iPhone",
                "isAsc":false,
                "isQueryInvitationBrand":false,
                "pageSize":20,
                "source":4,
                "ac":"WIFI"]
            parmeters["albumId"] = albumId
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
    
    
}
