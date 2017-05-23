//
//  JVShopcartBrandModel.swift
//  Swift_MJ
//
//  Created by LXY on 17/5/11.
//  Copyright © 2017年 AVGD. All rights reserved.
//

import UIKit



class JVShopcartBrandModel: NSObject,NSCopying {
    
    var brandName: String = ""
    
    var isSelected: Bool = false /* 是否选中标识*/
    
    var products: [JVShopcartProductModel] = []  /* 商品数组*/
    
    
    init(_ dict: NSDictionary) {
        
        super.init()
        
        if dict.count != 0{
            
            brandName = dict["brandName"] as! String
            
            let productArr = dict["products"] as! [NSDictionary]
            
            for productModel in productArr{
                
                let item = JVShopcartProductModel(productModel)
                products.append(item)
                
            }
        }
        
    }
   
    func copy(with zone: NSZone? = nil) -> Any{
     
     let dic:NSDictionary = [:]
     let brandModel = JVShopcartBrandModel(dic)
        brandModel.brandName = self.brandName
        brandModel.isSelected = self.isSelected
        brandModel.products = self.products

     return brandModel
    
    }

}
