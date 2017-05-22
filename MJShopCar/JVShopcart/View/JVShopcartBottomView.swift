//
//  MJTableHeadView.swift
//  long_s
//
//  Created by LXY on 16/11/28.
//  Copyright © 2016年 AVGD. All rights reserved.
//

import UIKit

class JVShopcartBottomView: UIView {
    var shopcartBotttomViewSettleBtnBlock:(() -> Void)?
    var shopcartBotttomViewAllSelectBlock:((_ isSelected:Bool) -> Void)?
    var shopcartBotttomViewDeleBtnBlock:(() -> Void)?
    var shopcartBotttomViewStarBtnBlock:(() -> Void)?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = RGB(r: 229, g: 229, b: 229).cgColor
        self.layer.borderWidth = 0.5
        
        self.addSubviewsForCell()
        
        self.addConstraintsForCell()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: ********************* 懒加载
    lazy var editView: UIView = {
        
        let view = UIView ()
        view.backgroundColor = UIColor.white
        view.isHidden = true
        
        return view
    }()
    lazy var starButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("移入关注", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(starButtonAction(_:)), for: .touchUpInside)
        
        return button
    }()
    lazy var deleButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("删除", for: .normal)
        button.setTitleColor(RGB(r: 235, g: 23, b: 37), for: .normal)
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.borderColor = RGB(r: 235, g: 23, b: 37).cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(deleButtonAction(_:)), for: .touchUpInside)
        
        return button
    }()
    lazy var totalPriceLable: UILabel = {
        
        let label = UILabel ()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "合计: ￥0.00"
        label.textColor = UIColor.black
        label.paragraphStyleWithArrString(arrString:["合计"],font: UIFont.systemFont(ofSize: 15))
        
        return label
    }()
    lazy var moneyLable: UILabel = {
        
        let label = UILabel ()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "总额:￥0.00"
        label.textColor = UIColor.black
        
        return label
    }()
    lazy var settleButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("去结算(0)", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = RGB(r: 235, g: 23, b: 37)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(settleButtonAction(_:)), for: .touchUpInside)
        
        return button
    }()
    lazy var allSelectButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("全选", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setImage(UIImage.init(named: "Unselected"), for: .normal)
        button.setImage(UIImage.init(named: "Selected"), for: .selected)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5)
        button.addTarget(self, action: #selector(allSelectButtonAction(_:)), for: .touchUpInside)
        
        
        return button
    }()
    
    var isShowEditView : Bool? {
        didSet{
            editView.isHidden = isShowEditView!
        }
    }
    
    //MARK: ********************* 全选按钮被点击
    func allSelectButtonAction(_ sender:UIButton)
    {
        sender.isSelected = !sender.isSelected
        if shopcartBotttomViewAllSelectBlock != nil{
            shopcartBotttomViewAllSelectBlock!(sender.isSelected)
        }
    }
    
    //MARK: ********************* 结算按钮被点击
    func settleButtonAction(_ sender:UIButton){
        if self.shopcartBotttomViewSettleBtnBlock != nil{
            self.shopcartBotttomViewSettleBtnBlock!()
        }
        
    }
    //MARK: ********************* 关注按钮被点击
    func starButtonAction(_ sender:UIButton){
        if self.shopcartBotttomViewStarBtnBlock != nil{
            self.shopcartBotttomViewStarBtnBlock!()
        }
    }
    //MARK: ********************* 删除按钮被点击
    func deleButtonAction(_ sender:UIButton){
        if self.shopcartBotttomViewDeleBtnBlock != nil{
            self.shopcartBotttomViewDeleBtnBlock!()
        }
    }
    
    func configureShopcartBottomViewWithTotalPrice(totalPrice:Float ,totalCount:Int ,isAllSelected:Bool ){

        allSelectButton.isSelected = isAllSelected
        totalPriceLable.text = "合计: ￥\(totalPrice)"
        settleButton.setTitle("去结算(\(totalCount))", for: .normal)
        moneyLable.text = "总额: ￥\(totalPrice)\n不含运费"
        
        totalPriceLable.paragraphStyleWithArrString(arrString:["合计"],font: UIFont.systemFont(ofSize: 15))
        
    }
    
    //MARK: ********************* 添加子控件
    func addSubviewsForCell()
    {
        self.addSubview(allSelectButton)
        self.addSubview(settleButton)
        self.addSubview(totalPriceLable)
        self.addSubview(moneyLable)
        
        self.addSubview(editView)
        self.editView.addSubview(starButton)
        self.editView.addSubview(deleButton)
        
    }
    
    //MARK: ********************* 子控件约束
    func addConstraintsForCell()
    {
  
        
        allSelectButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(7)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize.init(width: 70, height: 30))
        }
        settleButton.snp.makeConstraints { (make) -> Void in
            make.top.right.bottom.equalTo(self)
            make.width.equalTo(120)
        }
        totalPriceLable.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(5);
            make.left.equalTo(allSelectButton.snp.right).offset(5);
            make.right.equalTo(settleButton.snp.left).offset(-5);
        }
        moneyLable.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self).offset(-5);
            make.left.equalTo(allSelectButton.snp.right).offset(5);
            make.right.equalTo(settleButton.snp.left).offset(-5);
        }
        
        editView.snp.makeConstraints { (make) -> Void in
            make.top.right.bottom.equalTo(self)
            make.left.equalTo(allSelectButton.snp.right).offset(5)
        }
        deleButton.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(editView);
            make.width.height.equalTo(CGSize.init(width: 80, height: 35));
            make.right.equalTo(editView).offset(-10);
        }
        starButton.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(editView);
            make.width.height.equalTo(CGSize.init(width: 80, height: 35));
            make.right.equalTo(deleButton.snp.left).offset(-10);
        }
        
    }
}
