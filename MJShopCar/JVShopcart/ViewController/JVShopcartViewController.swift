//
//  JVShopcartViewController.swift
//  Swift_MJ
//
//  Created by LXY on 17/5/11.
//  Copyright © 2017年 AVGD. All rights reserved.
//

import UIKit

class JVShopcartViewController: UIViewController,JVShopcartFormatDelegate {
    
    var editIte:UIBarButtonItem?
    
    /**< 负责购物车逻辑处理 */
    lazy var shopcartFormat: JVShopcartFormat = {
        let shopcartFormat = JVShopcartFormat ()
        shopcartFormat.delegate = self
        shopcartFormat.viewController = self;
        return shopcartFormat
    }()
    
     /**< tableView代理 */
    lazy var shopcartTableViewProxy: JVShopcartTableViewProxy = {
        weak var weakSelf = self;
        let shopcartTableViewProxy = JVShopcartTableViewProxy ()
        shopcartTableViewProxy.shopcartProxyProductSelectBlock = {(isSelected,indexPath) in
            weakSelf?.shopcartFormat.selectProductAtIndexPath(indexPath: indexPath, isSelected: isSelected)
        }
        
        shopcartTableViewProxy.shopcartProxyBrandSelectBlock = {(isSelected,section) in
            weakSelf?.shopcartFormat.selectBrandAtSection(section: section, isSelected: isSelected)
        }
        
        shopcartTableViewProxy.shopcartProxyChangeCountBlock = {(count,indexPath) in
            weakSelf?.shopcartFormat.changeCountAtIndexPath(indexPath: indexPath, count: count)
        }
        
        shopcartTableViewProxy.shopcartProxyDeleteBlock = {(indexPath) in
             weakSelf?.shopcartFormat.deleteProductAtIndexPath(indexPath: indexPath)
        }
        
        shopcartTableViewProxy.shopcartProxyStarBlock = {(indexPath) in
            weakSelf?.shopcartFormat.starProductAtIndexPath(indexPath: indexPath)
        }
        
        return shopcartTableViewProxy
    }()
    
    /**< 购物车底部视图 */
    lazy var shopcartBottomView: JVShopcartBottomView = {
        weak var weakSelf = self;
        let view = JVShopcartBottomView ()
        view.backgroundColor = UIColor.white
        view.shopcartBotttomViewAllSelectBlock = {(isSelected) in
            weakSelf?.shopcartFormat.selectAllProductWithStatus(isSelected: isSelected)
        }
        
        view.shopcartBotttomViewDeleBtnBlock = {() in
            weakSelf?.shopcartFormat.shopcartBotttomViewDeleBtnBlock()
        }
        
        view.shopcartBotttomViewStarBtnBlock = {() in
            weakSelf?.shopcartFormat.shopcartBotttomViewDeleBtnBlock()
        }
        
        view.shopcartBotttomViewSettleBtnBlock = {() in
            var settleArr =  weakSelf?.shopcartFormat.shopcartBotttomViewSettleBtnBlock()
            print(settleArr?.count)
            //push 到 结算页面
        }
        
        return view
    }()
    
     /**< 购物车列表 */
    lazy var shopcartTableView: UITableView = {
        
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.delegate = self.shopcartTableViewProxy
        tableView.dataSource = self.shopcartTableViewProxy
        tableView.backgroundColor = RGB(r: 236, g: 239, b: 242)
        tableView.register(JVShopcartCell.self, forCellReuseIdentifier: "JVShopcartCell")
        tableView.register(JVShopcartHeaderView.self, forHeaderFooterViewReuseIdentifier: "JVShopcartHeaderView")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.setNav()
        self.addSubviewsForView()
        self.addConstraintsForView()
        requestShopcartListData()
    }
    //MARK: ************** 获取数据
    func requestShopcartListData(){
       shopcartTableViewProxy.dataArray = shopcartFormat.requestShopcartProductList()
    }

    //MARK: ************** 设置导航栏
    func setNav(){
        self.title = "购物车";
        self.view.backgroundColor = UIColor.white

        let button = UIButton ()
        button.setImage(UIImage.init(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(backBtn(_:)), for: .touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 25, height: 25)
        let leftItem = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = leftItem
        
        editIte = UIBarButtonItem.init(title: "编辑", style: .plain, target: self, action: #selector(clickBtn(_:)))
        editIte?.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = editIte
        
    }
    func clickBtn(_ sender:UIBarButtonItem){
        if editIte?.title == "编辑"{
            editIte?.title = "完成"
            shopcartBottomView.isShowEditView = false
        }else{
            editIte?.title = "编辑"
            shopcartBottomView.isShowEditView = true
        }
    }
    func backBtn(_ sender:UIButton){
       _ = self.navigationController?.popViewController(animated: true)
    }
    //MARK: ************** JVShopcartFormatDelegate 逻辑处理代理方法
    func shopcartFormatAccountForTotalPrice(totalPrice: Float, totalCount: Int, isAllSelected: Bool){
        shopcartBottomView.configureShopcartBottomViewWithTotalPrice(totalPrice: totalPrice, totalCount: totalCount, isAllSelected: isAllSelected)
        
        shopcartTableViewProxy.dataArray = shopcartFormat.shopcartListArray
        
        shopcartTableView.reloadData()
    }
    func shopcartFormatHasDeleteAllProducts(){
        
    }
    
    //MARK: ************** 添加子控件
    func addSubviewsForView(){
        self.view.addSubview(self.shopcartBottomView)
        self.view.addSubview(self.shopcartTableView)
    }
    
    //MARK: ************** 约束子控件
    func addConstraintsForView(){
        shopcartBottomView.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(50)
        }
        shopcartTableView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(64)
            make.bottom.equalTo(self.shopcartBottomView.snp.top)
        }
    }
    deinit {
        print("[\(NSStringFromClass(type(of: self)))]===已被释放")
    }

}
