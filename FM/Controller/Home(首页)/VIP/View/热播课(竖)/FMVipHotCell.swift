//
//  FMVipHotCell.swift
//  FM
//
//  Created by fengsong on 2020/4/30.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit

class FMVipHotCell: UICollectionViewCell {
    
    // 图片
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    // 标题
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpLayout(){
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
    }
    
    //Vip
    var categoryContentsModel:FMCategoryContents? {
        didSet {
            guard let model = categoryContentsModel else {return}
            self.imageView.kf.setImage(with: URL(string: model.coverLarge!))
            self.titleLabel.text = model.title
        }
    }
    //推荐
    var recommentContentsModel:FMRecommendListModel? {
        didSet {
            guard let model = recommentContentsModel else {return}
            if (model.pic != nil) {
                self.imageView.kf.setImage(with: URL(string: model.pic!))
            }
            if (model.coverPath != nil) {
                self.imageView.kf.setImage(with: URL(string: model.coverPath!))
            }
            self.titleLabel.text = model.title
        }
    }
    
    
}
