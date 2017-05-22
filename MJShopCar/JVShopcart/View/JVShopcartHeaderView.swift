//
//  JVShopcartHeaderView.swift
//  Swift_MJ
//
//  Created by LXY on 17/5/11.
//  Copyright © 2017年 AVGD. All rights reserved.
//

import UIKit

class JVShopcartHeaderView: UITableViewHeaderFooterView {
    
    var shopcartHeaderViewBlock:((_ isSelected:Bool) -> Void)?
    
    var brandModel : JVShopcartBrandModel? {
        didSet{
            self.titltLab.text = brandModel?.brandName
            self.productSelectButton.isSelected = (brandModel?.isSelected)!
        }
    }
    
    //MARK: ********************* 懒加载
    lazy var lineView: UIView = {
        
        let view = UIView ()
        view.backgroundColor = RGB(r: 236, g: 239, b: 242)
        view.layer.borderColor = RGB(r: 231, g: 234, b: 237).cgColor
        view.layer.borderWidth = 0.5
        
        return view
    }()
    lazy var cneterView: UIView = {
        let view = UIView ()
        view.backgroundColor = RGB(r: 249, g: 249, b: 249)
        return view
    }()
    lazy var productSelectButton: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage.init(named: "Unselected"), for: .normal)
        button.setImage(UIImage.init(named: "Selected"), for: .selected)
        button.addTarget(self, action: #selector(productSelectButtonAction(_:)), for: .touchUpInside)
        
        return button
    }()
    lazy var shopButton: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage.init(named: "shop"), for: .normal)
        
        return button
    }()
    lazy var shop_right_btn: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage.init(named: "shop_right"), for: .normal)
        
        return button
    }()
    lazy var titltLab: UILabel = {
        
        let label = UILabel ()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "我是懒加载"
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        
        return label
    }()
    
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = RGB(r: 249, g: 249, b: 249)
        self.addSubviewsForCell()
        
        self.addConstraintsForCell()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: ********************* 按钮被点击
    func productSelectButtonAction(_ sender:UIButton)
    {
        sender.isSelected = !sender.isSelected
        
        if shopcartHeaderViewBlock != nil{
            shopcartHeaderViewBlock!(sender.isSelected)
        }
        
    }
    //MARK: ********************* 添加子控件
    func addSubviewsForCell()
    {
        self.contentView.addSubview(lineView)
        self.contentView.addSubview(cneterView)

        self.cneterView.addSubview(titltLab)
        self.cneterView.addSubview(productSelectButton)
        self.cneterView.addSubview(shopButton)
        self.cneterView.addSubview(shop_right_btn)

        
    }
    
    //MARK: ********************* 子控件约束
    func addConstraintsForCell()
    {
        
        lineView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(10)
            make.top.left.right.equalTo(self.contentView)
        }
        cneterView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(lineView.snp.bottom)
            make.bottom.left.right.equalTo(self.contentView)
        }
        
        productSelectButton.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(30)
            make.centerY.equalTo(cneterView)
            make.left.equalTo(cneterView).offset(10)
        }
        shopButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(productSelectButton.snp.right).offset(10)
            make.centerY.equalTo(cneterView)
            make.height.width.equalTo(20)
        }
        
        titltLab.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(shopButton.snp.right).offset(5)
            make.centerY.equalTo(cneterView)
         }
        
        shop_right_btn.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(titltLab.snp.right).offset(3)
            make.centerY.equalTo(cneterView)
            make.height.width.equalTo(16)
        }
        
        
    }

}
