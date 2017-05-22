//
//  JVShopcartProductModel.swift
//  Swift_MJ
//
//  Created by LXY on 17/5/11.
//  Copyright © 2017年 AVGD. All rights reserved.
//

import UIKit

class JVShopcartProductModel: NSObject {
    
    var productName: String = ""
    var productRemark: String = ""
    var isSelected:Bool = false          /* 记录相应row是否选中（自定义）*/
    var productPrice: Float = 0.00
    var productQty: Int = 100
    var productPicUri: String = ""
    var productStocks: Int = 1

    init(_ dict: NSDictionary) {
        
        super.init()
        
        productName = dict["productName"] as! String
        productRemark = dict["productRemark"] as! String
        productPrice = dict["productPrice"] as! Float
        productQty = dict["productQty"] as! Int
        productStocks = dict["productStocks"] as! Int
        productPicUri = dict["productPicUri"] as! String
        
    }
}
