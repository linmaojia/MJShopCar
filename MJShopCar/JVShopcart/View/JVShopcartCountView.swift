//
//  JVShopcartCountView.swift
//  Swift_MJ
//
//  Created by LXY on 17/5/11.
//  Copyright © 2017年 AVGD. All rights reserved.
//

import UIKit

class JVShopcartCountView: UIView,UITextFieldDelegate {

    var shopcartCountViewEditBlock:((_ count:Int) -> Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviewsForCell()
        
        self.addConstraintsForCell()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: ********************* 懒加载
    lazy var increaseButton: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage.init(named: "product_detail_add_normal"), for: .normal)
        button.setImage(UIImage.init(named: "product_detail_add_no"), for: .selected)
        button.addTarget(self, action: #selector(increaseButtonAction(_:)), for: .touchUpInside)
        
        
        return button
    }()
    lazy var decreaseButton: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage.init(named: "product_detail_sub_normal"), for: .normal)
        button.setImage(UIImage.init(named: "product_detail_sub_no"), for: .selected)
        button.addTarget(self, action: #selector(decreaseButtonAction(_:)), for: .touchUpInside)
        
        
        return button
    }()
    lazy var editTextField: UITextField = {
        
        let textField = UITextField ()
        textField.delegate = self
        textField.layer.borderColor = RGB(r: 231, g: 234, b: 237).cgColor
        textField.layer.borderWidth = 1
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = UIColor.black
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(textChange(_:)), for: .editingChanged)
        
        return textField
    }()
    
    var model : JVShopcartProductModel? {
        didSet{
            
            let productQty = (model?.productQty)!
            
            let productStocks = (model?.productStocks)!

            if productQty == 1 {
                self.decreaseButton.isEnabled = false
                self.increaseButton.isEnabled = true
            } else if productQty == productStocks {
                self.decreaseButton.isEnabled = true;
                self.increaseButton.isEnabled = false;
            } else {
                self.decreaseButton.isEnabled = true;
                self.increaseButton.isEnabled = true;
            }
            
            self.editTextField.text = "\(productQty)";
        }
    }
    
    //MARK: ********************* 时刻监听文本框
    func textChange(_ sender:UITextField)
    {
        if sender.text != ""{
            
            let count = Int(sender.text!)!
            
            if count > (self.model?.productStocks)!{
                
                sender.text = "\((self.model?.productStocks)!)"
                
                SVProgressHUD.showInfo(withStatus: "最多只能买" + sender.text! + "件哦!")
            }
            
            print(count)
        }
        
     
    }

    func textFieldDidEndEditing(_ textField: UITextField){
        
        var count = 0
        
        if textField.text != ""{
            count = Int(self.editTextField.text!)!
        }
        
        if shopcartCountViewEditBlock != nil{
            shopcartCountViewEditBlock!(count)
        }
        
    }

    func increaseButtonAction(_ sender:UIButton){
        print("+++++")
        let count:Int? = Int(self.editTextField.text!)
    
        if shopcartCountViewEditBlock != nil{
            shopcartCountViewEditBlock!(count! + 1)
        }
    }
    func decreaseButtonAction(_ sender:UIButton){
         print("----")
        let count:Int? = Int(self.editTextField.text!)
        
        if shopcartCountViewEditBlock != nil{
            shopcartCountViewEditBlock!(count! - 1)
        }
    }
    
    //MARK: ********************* 添加子控件
    func addSubviewsForCell(){
      
        self.addSubview(editTextField)
        self.addSubview(increaseButton)
        self.addSubview(decreaseButton)

    }
    
    //MARK: ********************* 子控件约束
    func addConstraintsForCell(){
        
        decreaseButton.snp.makeConstraints { (make) -> Void in
            make.left.top.bottom.equalTo(self);
            make.width.equalTo(self.snp.height);
        }
        increaseButton.snp.makeConstraints { (make) -> Void in
            make.right.top.bottom.equalTo(self);
            make.width.equalTo(self.snp.height);
        }
        editTextField.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.decreaseButton.snp.right);
            make.right.equalTo(self.increaseButton.snp.left);
        }
        
    }

}
