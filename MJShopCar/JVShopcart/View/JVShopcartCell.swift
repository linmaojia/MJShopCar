//
//  MJTableViewCell.swift
//  long_s
//
//  Created by LXY on 16/11/28.
//  Copyright © 2016年 AVGD. All rights reserved.
//

import UIKit

class JVShopcartCell: UITableViewCell {
    
    var shopcartCellBlock:((_ isSelected:Bool) -> Void)?
    var shopcartCellEditBlock:((_ count:Int) -> Void)?
    
    var model : JVShopcartProductModel? {
        didSet{
            
             titltLab.text = model?.productName
             remarkLab.text = model?.productRemark
            
             let priceString = String(format: "￥%.2f", (model?.productPrice)!)
             let range = priceString.range(of: ".")
             let nextString = priceString.substring(from: (range?.lowerBound)!)
             productPriceLab.text = priceString
             productPriceLab.paragraphStyleWithArrString(arrString:["￥",nextString],font: UIFont.systemFont(ofSize: 12))

             productSelectButton.isSelected = (model?.isSelected)!
             let urlString = model?.productPicUri
             let url = urlString?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
             titleImg.sd_setImage(with: URL.init(string: url!), placeholderImage: UIImage.init(named: "logo"))
            
             shopcartCountView.model = model
        }
    }
    //MARK: ********************* 懒加载
    lazy var productSelectButton: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage.init(named: "Unselected"), for: .normal)
        button.setImage(UIImage.init(named: "Selected"), for: .selected)
        button.addTarget(self, action: #selector(productSelectButtonAction(_:)), for: .touchUpInside)
        
        
        return button
    }()
    lazy var lineView: UIView = {
        
        let view = UIView ()
        view.backgroundColor = RGB(r: 231, g: 234, b: 237)
        return view
    }()
    lazy var titltLab: UILabel = {
        
        let label = UILabel ()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "我是标题"
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 2
        
        return label
    }()
    lazy var remarkLab: UILabel = {
        
        let label = UILabel ()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "副标题"
        label.textColor = UIColor.gray
        label.textAlignment = .left
        
        return label
    }()
    lazy var productPriceLab: UILabel = {
        
        let label = UILabel ()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "￥4599.00"
        label.textColor = RGB(r: 235, g: 23, b: 37)
        label.textAlignment = .left
        
        return label
    }()
    lazy var titleImg: UIImageView = {
        
        let imgView = UIImageView ()
        imgView.image = UIImage.init(named: "logo")
        imgView.layer.borderColor = RGB(r: 229, g: 229, b: 229).cgColor
        imgView.layer.borderWidth = 0.5
        imgView.layer.cornerRadius = 3
        imgView.layer.masksToBounds = true
        return imgView
    }()
    lazy var shopcartCountView: JVShopcartCountView = {
        weak var weakSelf = self;
        let view = JVShopcartCountView ()
        view.shopcartCountViewEditBlock = {(count) in
            
            if weakSelf?.shopcartCellEditBlock != nil{
                weakSelf?.shopcartCellEditBlock!(count)
            }
        }
        return view
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubviewsForCell()
        
        self.addConstraintsForCell()
        
    }
    //MARK: ********************* 按钮被点击
    func productSelectButtonAction(_ sender:UIButton)
    {
        sender.isSelected = !sender.isSelected
        if shopcartCellBlock != nil{
            shopcartCellBlock!(sender.isSelected)
        }
    }
    
    //MARK: ********************* 添加子控件
    func addSubviewsForCell()
    {
        self.contentView.addSubview(productSelectButton)
        self.contentView.addSubview(titleImg)
        self.contentView.addSubview(titltLab)
        self.contentView.addSubview(remarkLab)
        self.contentView.addSubview(productPriceLab)
        self.contentView.addSubview(shopcartCountView)
        self.contentView.addSubview(lineView)


    }
    
    //MARK: ********************* 子控件约束
    func addConstraintsForCell()
    {
        lineView.snp.makeConstraints { (make) -> Void in
            make.right.left.equalTo(self.contentView)
            make.height.equalTo(0.5)
            make.bottom.equalTo(self.contentView)
        }
        productSelectButton.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(30)
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(10)
        }
        titleImg.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(90)
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(productSelectButton.snp.right).offset(10)
        }
        titltLab.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(titleImg.snp.right).offset(10)
            make.right.equalTo(self.contentView).offset(-25)
            make.top.equalTo(titleImg)
            make.height.equalTo(35)
        }
        remarkLab.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(titltLab)
            make.right.equalTo(self.contentView).offset(-25)
            make.top.equalTo(titltLab.snp.bottom).offset(5)
        }
        productPriceLab.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(titltLab)
            make.bottom.equalTo(titleImg)
        }
        shopcartCountView.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self.contentView).offset(-10);
            make.bottom.equalTo(titleImg);
            make.size.equalTo(CGSize.init(width: 90, height: 25))
        }
        
        
    }
    
    
}
