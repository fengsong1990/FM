//
//  FMRecommendBuzzCell.swift
//  FM
//
//  Created by fengsong on 2020/5/7.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit

class FMRecommendBuzzCell: UICollectionViewCell {
    
    // 图片
    private var picView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    // 标题
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    // 子标题
    private var subLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    func setupLayout(){
        
        self.addSubview(self.picView)
        self.picView.image = UIImage(named: "pic1.jpeg")
        self.picView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(5)
            make.width.height.equalTo(50)
        }
        self.addSubview(self.titleLabel)
        self.titleLabel.text = "明朝那些事"
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.picView.snp.right).offset(10)
            make.right.equalToSuperview()
            make.top.equalTo(self.picView)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.subLabel)
        self.subLabel.text = "说服力的积分乐山大佛大"
        self.subLabel.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(self.titleLabel)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    var topBuzzModel:FMTopBuzzModel? {
        didSet {
            guard let model = topBuzzModel else {return}
            //self.picView.kf.setImage(with: URL(string: model.coverLarge!))
            self.picView.kf.setImage(with: URL.init(string: model.coverSmall!))
            self.titleLabel.text = model.nickname
            self.subLabel.text = model.title
        }
    }
    
}
