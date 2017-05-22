//
//  UILabelExtension.swift
//  MJShopCar
//
//  Created by LXY on 17/5/20.
//  Copyright © 2017年 林天宝. All rights reserved.
//

import Foundation

extension UILabel{
    /**
     @method 指定的字符串修改字体
     
     @param arrString 字符串数组
     @param font      字体
     */
    func paragraphStyleWithArrString( arrString:[String] , font:UIFont){
        
        let textAlignment = self.textAlignment
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = 4.0
        let ats = [NSParagraphStyleAttributeName:paragraphStyle]
        let paragraphString = NSMutableAttributedString.init(string: self.text!, attributes: ats)
        let strNumber: NSString = self.text! as NSString
        for textS in arrString {
            paragraphString.addAttribute(NSFontAttributeName, value: font, range: strNumber.range(of: textS))
        }
        self.attributedText = paragraphString
        self.textAlignment = textAlignment
        
    }
}
