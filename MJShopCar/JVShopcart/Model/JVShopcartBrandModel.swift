//
//  JVShopcartBrandModel.swift
//  Swift_MJ
//
//  Created by LXY on 17/5/11.
//  Copyright © 2017年 AVGD. All rights reserved.
//

import UIKit

class JVShopcartBrandModel: NSObject {
    
    var brandName: String = ""
    
    var isSelected: Bool = false /* 是否选中标识*/
    
    var products: [JVShopcartProductModel] = []  /* 商品数组*/
    
    
    init(_ dict: NSDictionary) {
        
        super.init()
        
        brandName = dict["brandName"] as! String
        
        let productArr = dict["products"] as! [NSDictionary]
        
        for productModel in productArr{
            
            let item = JVShopcartProductModel(productModel)
            products.append(item)
            
        }
    }
    
}
