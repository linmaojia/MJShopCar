//
//  Const.swift
//  swift_longma
//
//  Created by LXY on 17/5/3.
//  Copyright © 2017年 AVGD. All rights reserved.
//

import UIKit

/*=================================第三方库===============================================*/
import SnapKit


/*=================================尺寸(适配)===============================================*/
/* 屏幕宽度和高度*/
let SCREEN_WIDTH = (UIScreen.main.bounds.size.width)
let SCREEN_HEIGHT = (UIScreen.main.bounds.size.height)


/*=================================UI===============================================*/
/*颜色*/
func RGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
func RGB(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}


