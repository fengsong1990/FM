//
//  FMHomeRecommendTopBuzzCell.swift
//  FM
//
//  Created by fengsong on 2020/5/7.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit

protocol FMHomeRecommendTopBuzzCellDelegate : NSObjectProtocol {
    func homeRecommendTopBuzzCellItemClick(model:FMTopBuzzModel)
}

private let FMHomeRecommendTopBuzzCellIdentifier = "FMHomeRecommendTopBuzzCellIdentifier"

class FMHomeRecommendTopBuzzCell: UITableViewCell {

   private lazy var collectionView : UICollectionView = {
       let layout = UICollectionViewFlowLayout.init()
       let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
       collectionView.delegate = self
       collectionView.dataSource = self
       collectionView.backgroundColor = UIColor.white
       collectionView.showsVerticalScrollIndicator = false
       collectionView.showsHorizontalScrollIndicator = false
       collectionView.alwaysBounceVertical = false
       collectionView.alwaysBounceHorizontal = false
       collectionView.bounces = false
       collectionView.register(FMRecommendBuzzCell.self, forCellWithReuseIdentifier: FMHomeRecommendTopBuzzCellIdentifier)
       return collectionView
   }()
   
   weak var delegate : FMHomeRecommendTopBuzzCellDelegate?
   private var topBuzzContents:[FMTopBuzzModel]?
   var categoryContentsModel:[FMTopBuzzModel]? {
       didSet {
           guard let model = categoryContentsModel else {return}
           self.topBuzzContents = model
           self.collectionView.reloadData()
       }
   }
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: .default, reuseIdentifier: reuseIdentifier)
      
       self.addSubview(self.collectionView)
       self.collectionView.snp.makeConstraints { (make) in
           make.left.equalToSuperview().offset(15)
           make.right.equalToSuperview().offset(-15)
           make.height.equalToSuperview()
       }
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
}
extension FMHomeRecommendTopBuzzCell:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.topBuzzContents?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:FMRecommendBuzzCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMHomeRecommendTopBuzzCellIdentifier, for: indexPath) as! FMRecommendBuzzCell
        cell.topBuzzModel = self.topBuzzContents?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.homeRecommendTopBuzzCellItemClick(model: (self.topBuzzContents?[indexPath.row])!)
    }
}
extension FMHomeRecommendTopBuzzCell:UICollectionViewDelegateFlowLayout{
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:FMScreenWidth,height:FMItemHeight2)
    }
}
