//
//  JVShopcartFormat.swift
//  Swift_MJ
//
//  Created by LXY on 17/5/11.
//  Copyright © 2017年 AVGD. All rights reserved.

/**< 负责购物车逻辑处理 */
import UIKit

/* 设置协议方法*/
protocol JVShopcartFormatDelegate:NSObjectProtocol {
    /* 计算价格,产品个数代理*/
    func shopcartFormatAccountForTotalPrice(totalPrice: Float, totalCount: Int, isAllSelected: Bool)
    
    /* 所有商品都被删除代理*/
    func shopcartFormatHasDeleteAllProducts()
}


class JVShopcartFormat: NSObject{
    
    weak var viewController:JVShopcartViewController?
    
    weak var delegate:JVShopcartFormatDelegate?
    
    var shopcartListArray = [JVShopcartBrandModel]()
    
    /* 获取数据*/
    func requestShopcartProductList() -> [JVShopcartBrandModel] {
        
       let plistPath = Bundle.main.path(forResource: "shopcart", ofType: "plist")
        
       let  dataArray =  NSArray.init(contentsOfFile: plistPath!)
        
        for model in dataArray! {
            
            let item = JVShopcartBrandModel(model as! NSDictionary)
            shopcartListArray.append(item)
            
        }
        
        return shopcartListArray
        
    }
    //MARK: ********************* 全选点击
    func selectAllProductWithStatus(isSelected: Bool){
        
        for brandModel in shopcartListArray as [JVShopcartBrandModel] {
            brandModel.isSelected = isSelected
            for productModel in brandModel.products as [JVShopcartProductModel] {
                productModel.isSelected = isSelected
            }
        }
        
        delegate?.shopcartFormatAccountForTotalPrice(totalPrice: self.accountTotalPrice(),totalCount: self.accountTotalCount(),isAllSelected: self.isAllSelected())
    }
    //MARK: ********************* 结算点击
    func shopcartBotttomViewSettleBtnBlock() -> [JVShopcartBrandModel]{
        
        var settleArr = shopcartListArray
        
        for  brandModel in settleArr
        {
            
            for  productModel in brandModel.products
            {
                if productModel.isSelected == false //删除cell
                {
                    let index = brandModel.products.index(of: productModel)
                    brandModel.products.remove(at: index!)
                }
                
            }
            if brandModel.products.count == 0 //删除section
            {
                let index = settleArr.index(of: brandModel)
                settleArr.remove(at: index!)
            }
            
        }
      
        return settleArr
    }
    func deleteChooseCell(){
        
        for  brandModel in shopcartListArray
        {
            if brandModel.isSelected == true //删除section
            {
                let index = shopcartListArray.index(of: brandModel)
                shopcartListArray.remove(at: index!)
            }
            else
            {
                for  productModel in brandModel.products
                {
                    if productModel.isSelected == true //删除cell
                    {
                        let index = brandModel.products.index(of: productModel)
                        brandModel.products.remove(at: index!)
                    }
                    
                }
            }
        }
        
        delegate?.shopcartFormatAccountForTotalPrice(totalPrice: self.accountTotalPrice(),totalCount: self.accountTotalCount() ,isAllSelected: self.isAllSelected())
    }
    //MARK: ********************* 多选删除，移入收藏
    func shopcartBotttomViewDeleBtnBlock(){
        
        let alertController = UIAlertController.init(title: "确定从购物车删除所选商品吗?", message: nil, preferredStyle: .actionSheet)
        let sureAction = UIAlertAction.init(title: "确定", style: .destructive) { (action) in
            self.deleteChooseCell();
        }
        
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (action) in}
        alertController.addAction(sureAction)
        alertController.addAction(cancelAction)
        
        viewController?.present(alertController, animated: true, completion: nil)
 
        
    }
    
    //MARK: ********************* cell选中
    func selectProductAtIndexPath(indexPath: IndexPath, isSelected: Bool) {
        
        let brandModel = shopcartListArray[indexPath.section]
        
        let productModel = brandModel.products[indexPath.row]
        
        productModel.isSelected = isSelected
        
        var isBrandSelected:Bool = true
        
        for ProductModel in brandModel.products as [JVShopcartProductModel] {
            
            if ProductModel.isSelected == false{
                
                isBrandSelected = false
            }
        }
        
        brandModel.isSelected = isBrandSelected;
        
        delegate?.shopcartFormatAccountForTotalPrice(totalPrice: self.accountTotalPrice(),totalCount: self.accountTotalCount() ,isAllSelected: self.isAllSelected())
        
    }
    //MARK: ********************* 删除cell
    func deleteProductAtIndexPath(indexPath: IndexPath) {
      
        let alertController = UIAlertController.init(title: "确定从购物车删除此商品?", message: nil, preferredStyle: .actionSheet)
        let sureAction = UIAlertAction.init(title: "确定", style: .destructive) { (action) in
            self.deleteProductAtIndexPathNext(indexPath: indexPath)
        }
        
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (action) in}
        alertController.addAction(sureAction)
        alertController.addAction(cancelAction)

        viewController?.present(alertController, animated: true, completion: nil)
        
    }
    func deleteProductAtIndexPathNext(indexPath: IndexPath){
        
        let brandModel = self.shopcartListArray[indexPath.section]
        
        //根据请求结果决定是否删除
        SVProgressHUD.showSuccess(withStatus: "删除成功")
        
        brandModel.products.remove(at: indexPath.row)
        
        if brandModel.products.count == 0 {
            self.shopcartListArray.remove(at: indexPath.section)
        }
        
        self.delegate?.shopcartFormatAccountForTotalPrice(totalPrice: self.accountTotalPrice(),totalCount: self.accountTotalCount() ,isAllSelected: self.isAllSelected())
        
        if self.shopcartListArray.count == 0{
            self.delegate?.shopcartFormatHasDeleteAllProducts()
        }

        
    }
    //MARK: ********************* 收藏商品
    func starProductAtIndexPath(indexPath: IndexPath){
        
        SVProgressHUD.showSuccess(withStatus: "收藏成功")
        
        delegate?.shopcartFormatAccountForTotalPrice(totalPrice: self.accountTotalPrice(),totalCount: self.accountTotalCount() ,isAllSelected: self.isAllSelected())
    }
    
    
    //MARK: ********************* 分区头选中
    func selectBrandAtSection(section: Int, isSelected: Bool) {
        
        let brandModel = shopcartListArray[section]
        brandModel.isSelected = isSelected
        
        for ProductModel in brandModel.products as [JVShopcartProductModel] {
             ProductModel.isSelected = brandModel.isSelected;
        }
        
        delegate?.shopcartFormatAccountForTotalPrice(totalPrice: self.accountTotalPrice(),totalCount: self.accountTotalCount() ,isAllSelected: self.isAllSelected())
        
    }
    //MARK: ********************* 修改数量
    func changeCountAtIndexPath(indexPath: IndexPath, count: Int) {
        var Count = count
        
        let brandModel = self.shopcartListArray[indexPath.section]
        
        let productModel = brandModel.products[indexPath.row];
        
        self.selectProductAtIndexPath(indexPath: indexPath, isSelected: true)
        
        if Count <= 0
        {
            //删除cell
            self.deleteProductAtIndexPath(indexPath: indexPath)
            Count = 1
        }
        else if count > productModel.productStocks {
            
            Count = productModel.productStocks;
            
        }
        
        //根据请求结果决定是否改变数据
        productModel.productQty = Count;
        
        delegate?.shopcartFormatAccountForTotalPrice(totalPrice: self.accountTotalPrice(),totalCount: self.accountTotalCount() ,isAllSelected: self.isAllSelected())
        
    }
    //MARK: ********************* 计算价格
    func accountTotalPrice() -> Float{
        
        var totalPrice:Float = 0.0;
        for brandModel in self.shopcartListArray as [JVShopcartBrandModel] {
            for productModel in brandModel.products as [JVShopcartProductModel]  {
                if productModel.isSelected{
                    totalPrice += productModel.productPrice * Float(productModel.productQty);
                }
            }
        }
        
        return Float(totalPrice);
    
    }
    //MARK: ********************* 计算个数
    func accountTotalCount() -> Int{
        
        var totalCount = 0;
        
        for  brandModel in shopcartListArray as [JVShopcartBrandModel] {
            for  productModel in brandModel.products as [JVShopcartProductModel]{
                if productModel.isSelected{
                    totalCount += productModel.productQty;
                }
            }
        }
        
        return totalCount;
    }
    //MARK: ********************* 判断是否全选
    func isAllSelected() -> Bool{
        if shopcartListArray.count == 0{
            return false;
        }
        
        var isAllSelected = true;
        
        for  brandModel in shopcartListArray as [JVShopcartBrandModel]{
            if brandModel.isSelected == false {
                isAllSelected = false;
            }
        }
        
        return isAllSelected;
    }
    
}
