//
//  FMRefresh.swift
//  FM
//
//  Created by fengsong on 2020/4/30.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit
import MJRefresh


extension UIScrollView{
    var uHeader:MJRefreshHeader{
        get{return mj_header!}
        set{mj_header = newValue}
    }
    var uFoot: MJRefreshFooter {
        get { return mj_footer! }
        set { mj_footer = newValue }
    }
}

class FMRefresh: MJRefreshGifHeader {
    
    override func prepare() {
        super.prepare()
        
        setImages([UIImage(named: "pullToRefresh_0_80x60_")!], for: .idle)
        setImages([UIImage(named: "pullToRefresh_0_80x60_")!], for: .pulling)
        setImages([UIImage(named: "pullToRefresh_0_80x60_")!,
                   UIImage(named: "pullToRefresh_1_80x60_")!,
                   UIImage(named: "pullToRefresh_2_80x60_")!,
                   UIImage(named: "pullToRefresh_3_80x60_")!,
                   UIImage(named: "pullToRefresh_4_80x60_")!,
                   UIImage(named: "pullToRefresh_5_80x60_")!,
                   UIImage(named: "pullToRefresh_6_80x60_")!,
                   UIImage(named: "pullToRefresh_7_80x60_")!,
                   UIImage(named: "pullToRefresh_8_80x60_")!,
                   UIImage(named: "pullToRefresh_9_80x60_")!], for: .refreshing)
        
        lastUpdatedTimeLabel!.isHidden = true
        stateLabel!.isHidden = true
    }
}

class FMRefreshAutoHeader:MJRefreshHeader{}
