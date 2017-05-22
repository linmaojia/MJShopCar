//
//  ViewController.swift
//  Swift_MJ
//
//  Created by LXY on 17/5/11.
//  Copyright © 2017年 AVGD. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    lazy var titleImg: UIImageView = {
        
        let imgView = UIImageView ()
        imgView.image = UIImage.init(named: "mycar")
        imgView.backgroundColor = UIColor.clear
        imgView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action:#selector(clickImg(_:)))
        imgView.addGestureRecognizer(tap)
        return imgView
    }()
    
    func clickImg(_ sender:UITapGestureRecognizer){
        self.navigationController?.pushViewController(JVShopcartViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "购物车";
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(titleImg)
        self.titleImg.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(60)
            make.center.equalTo(self.view)
        }
        
    }
    
    
    
}

