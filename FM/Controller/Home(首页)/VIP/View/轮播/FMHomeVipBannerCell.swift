//
//  FMHomeVipBannerCell.swift
//  FM
//
//  Created by fengsong on 2020/4/28.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit
import FSPagerView


protocol FMHomeVipBannerCellDelegate : NSObjectProtocol {
    func homeVipBannerCellClick(url:String)
}

let FMHomePageViewIdentifier = "FMHomePageViewIdentifier"

class FMHomeVipBannerCell: UITableViewCell {
    
    // - 懒加载滚动图片浏览器
    private lazy var pagerView : FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval =  3
        pagerView.isInfinite = true
        pagerView.interitemSpacing = 15
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: FMHomePageViewIdentifier)
        return pagerView
    }()
    
    weak var delegate : FMHomeVipBannerCellDelegate?
    var vipBanner: [FMFocusImagesData]?
    var vipBannerList : [FMFocusImagesData]?{
        didSet {
            guard let model = vipBannerList else { return }
            self.vipBanner = model
            self.pagerView.reloadData()
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.pagerView)
        self.pagerView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        self.pagerView.itemSize = CGSize.init(width: FMScreenWidth-60, height: 140)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FMHomeVipBannerCell:FSPagerViewDelegate, FSPagerViewDataSource{
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.vipBanner?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: FMHomePageViewIdentifier, at: index)
        cell.imageView?.kf.setImage(with: URL(string:(self.vipBanner?[index].cover)!))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
        let url:String = self.vipBanner?[index].link ?? ""
        delegate?.homeVipBannerCellClick(url: url)
    }
    
}
