//
//  LBFMCustomLabel.swift
//  FM
//
//  Created by JCSON on 2018/8/21.
//  Copyright © 2018年 liubo. All rights reserved.
//

import UIKit
// label 文字从坐上角开始显示(默认是居中)
class FMCustomLabel: UILabel {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        textRect.origin.y = bounds.origin.y
        return textRect
    }
    
    override func drawText(in rect: CGRect) {
        let actualRect = self.textRect(forBounds: rect, limitedToNumberOfLines: self.numberOfLines)
        super.drawText(in: actualRect)
    }
    
    static func getTextHeight(text:String,fontValue:CGFloat,maxW:CGFloat,maxH:CGFloat) -> CGSize{
        
        let mutString = NSMutableAttributedString.init(string: text, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: fontValue)])
        let mutSize = mutString.boundingRect(with: CGSize.init(width: maxW, height: maxH), options:.usesLineFragmentOrigin , context: nil).size
        return mutSize
    }
    
    static func attributedText(text:String,fontValue:CGFloat) ->NSMutableAttributedString{
        return  NSMutableAttributedString.init(string: text, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: fontValue)])
    }
    
}
