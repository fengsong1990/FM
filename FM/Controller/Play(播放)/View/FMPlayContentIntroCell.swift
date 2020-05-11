//
//  FMPlayContentIntroCell.swift
//  FM
//
//  Created by fengsong on 2020/5/11.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit

class FMPlayContentIntroCell: UITableViewCell {
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "内容简介"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    // 内容详情
    private lazy var subLabel:FMCustomLabel = {
        let label = FMCustomLabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    func setUpUI(){
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(15)
            make.right.equalToSuperview()
            make.height.equalTo(30)
        }
        self.addSubview(self.subLabel)
        self.subLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.bottom.right.equalToSuperview().offset(-15)
        }
    }
    
    var playDetailAlbumModel:FMPlayDetailAlbumModel? {
        didSet{
            guard let model = playDetailAlbumModel else {return}
            //self.subLabel.text = model.shortIntro
            self.subLabel.attributedText = FMCustomLabel.attributedText(text: model.intro ?? "", fontValue: 15)
            
//            let mutString = NSMutableAttributedString.init(string: model.intro ?? "", attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15)])
//            self.subLabel.attributedText = mutString
        }
    }
    
    static func getCellHeight(model:FMPlayDetailAlbumModel?) -> CGFloat{
        
        let textSize = FMCustomLabel.getTextHeight(text: model?.intro ?? "", fontValue: 15, maxW: FMScreenWidth-30, maxH: 800)
        return textSize.height + 45 + 15 + 2 //多加一点
        
        //        let mutString = NSMutableAttributedString.init(string: model?.intro ?? "", attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15)])
        //        let mutSize = mutString.boundingRect(with: CGSize.init(width: FMScreenWidth-30, height: 800), options:.usesLineFragmentOrigin , context: nil).size
        //        return mutSize.height + 45 + 15 + 2 //多加一点
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
