//
//  FMHomeRecommendApi.swift
//  FM
//
//  Created by fengsong on 2020/5/6.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit
import Moya

/// 首页推荐主接口
let FMRecommendProvider = MoyaProvider<FMHomeRecommendApi>()

enum FMHomeRecommendApi {
    // 推荐列表
    case recommendList
}
extension FMHomeRecommendApi:TargetType{
    var baseURL: URL {
        switch self {
        case .recommendList:
            return URL(string: "http://mobile.ximalaya.com")!
        }
    }
    
    var path: String {
        switch self {
        case .recommendList: return "/discovery-firstpage/v2/explore/ts-1532411485052"
        }
    }
    
    var method: Moya.Method { return .get }
    
    
    var task: Task {
        
        var parmeters:[String:Any] = [:]
        switch self {
        case .recommendList:
            parmeters = [
                "device":"iPhone",
                "appid":0,
                "categoryId":-2,
                "channel":"ios-b1",
                "code":"43_310000_3100",
                "includeActivity":true,
                "includeSpecial":true,
                "network":"WIFI",
                "operator":3,
                "pullToRefresh":true,
                "scale":3,
                "uid":0,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
    
    
}
