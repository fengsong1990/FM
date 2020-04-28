//
//  FMBasicBarItemContentView.swift
//  FM
//
//  Created by fengsong on 2020/4/27.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit
import ESTabBarController_swift

///正常的BarItem
class FMBasicBarItemContentView: ESTabBarItemContentView {
    
    var duration = 0.3
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //颜色的变化
        textColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor.init(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1.0)
        iconColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor.init(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1.0)
    }
    
    //点击动画
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    func bounceAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = duration * 2
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        imageView.layer.add(impliesAnimation, forKey: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

///放大版非正常的BarItem
class FMIrregularityBarItemContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView.backgroundColor = UIColor.init(red: 250/255.0, green: 48/255.0, blue: 32/255.0, alpha: 1.0)
        self.imageView.layer.borderWidth = 2.0
        self.imageView.layer.borderColor = UIColor.init(white: 235 / 255.0, alpha: 1.0).cgColor
        //图片的尺寸是 50*50
        self.imageView.layer.cornerRadius = 25
        //偏移坐标
        self.insets = UIEdgeInsets.init(top: -23, left: 0, bottom: 0, right: 0)
//        let transform = CGAffineTransform.identity
//        self.imageView.transform = transform
//        self.superview?.bringSubviewToFront(self)
        
        
        //统一颜色样式
        textColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        iconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        backdropColor = .clear
        highlightBackdropColor = .clear
    }
    
    //    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    //        let p = CGPoint.init(x: point.x - imageView.frame.origin.x, y: point.y - imageView.frame.origin.y)
    //        return sqrt(pow(imageView.bounds.size.width / 2.0 - p.x, 2) + pow(imageView.bounds.size.height / 2.0 - p.y, 2)) < imageView.bounds.size.width / 2.0
    //    }
    
    //图片自适应大小+钉死中心点
    override func updateLayout() {
        super.updateLayout()
        self.imageView.sizeToFit()
        self.imageView.center = CGPoint.init(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
