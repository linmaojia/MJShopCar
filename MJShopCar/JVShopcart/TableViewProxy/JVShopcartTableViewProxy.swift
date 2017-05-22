//
//  JVShopcartTableViewProxy.swift
//  Swift_MJ
//
//  Created by LXY on 17/5/11.
//  Copyright © 2017年 AVGD. All rights reserved.
//
/**< tableView代理 */
import UIKit

class JVShopcartTableViewProxy: NSObject ,UITableViewDelegate, UITableViewDataSource {
    /* 商品选中回调*/
    var shopcartProxyProductSelectBlock:((_ isSelected:Bool, _ indexPath:IndexPath) -> Void)?
    
     /* 品牌选中回调*/
    var shopcartProxyBrandSelectBlock:((_ isSelected:Bool, _ section:Int) -> Void)?
    
     /* 商品数量修改回调*/
    var shopcartProxyChangeCountBlock:((_ count:Int, _ indexPath:IndexPath) -> Void)?
    
     /* 商品删除回调*/
    var shopcartProxyDeleteBlock:(( _ indexPath:IndexPath) -> Void)?
    
     /* 商品收藏回调*/
    var shopcartProxyStarBlock:(( _ indexPath:IndexPath) -> Void)?

    var dataArray = [JVShopcartBrandModel]()
    
    
    //MARK: ********************* UITableView 代理方法
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let brandModel = dataArray[section]
        return brandModel.products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = JVShopcartCell(style: .subtitle, reuseIdentifier: "JVShopcartCell")
        cell.selectionStyle = .none
        let brandModel = dataArray[indexPath.section]
        let productModel = brandModel.products[indexPath.row]
        cell.model = productModel
        cell.shopcartCellBlock = {(isSelected) in
            if self.shopcartProxyProductSelectBlock != nil{
                self.shopcartProxyProductSelectBlock!(isSelected,indexPath)
            }
        }
        cell.shopcartCellEditBlock = {(count) in
            if self.shopcartProxyChangeCountBlock != nil{
                self.shopcartProxyChangeCountBlock!(count,indexPath)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    /*分区头部部高度*/
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeadView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "JVShopcartHeaderView") as! JVShopcartHeaderView
        
        let brandModel = dataArray[section]
        
        sectionHeadView.brandModel = brandModel
        
        sectionHeadView.shopcartHeaderViewBlock = {(isSelected) in
            if self.shopcartProxyBrandSelectBlock != nil{
                self.shopcartProxyBrandSelectBlock!(isSelected,section)
            }
        }
        
        return sectionHeadView
        
    }
    /*分区尾部高度*/
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    /*左滑删除*/
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteRowAction = UITableViewRowAction.init(style: .destructive, title: "删除") { (action, indexPath) in
            if self.shopcartProxyDeleteBlock != nil{
                self.shopcartProxyDeleteBlock!(indexPath)
            }
        }
        
        let starAction = UITableViewRowAction.init(style: .destructive, title: "收藏") { (action, indexPath) in
            if self.shopcartProxyStarBlock != nil{
                self.shopcartProxyStarBlock!(indexPath)
            }
        }
        starAction.backgroundColor = UIColor.orange
        
        return [deleteRowAction, starAction]
    }
    
    
    
}
