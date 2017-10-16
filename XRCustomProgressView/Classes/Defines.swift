//
//  Defines.swift
//  XRCustomProgressView
//
//  Created by xuran on 2017/10/1.
//  Copyright © 2017年 xuran. All rights reserved.
//

import Foundation
import UIKit

//MARK: - 颜色
// 颜色(RGB)
func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor
{
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func  RGBCOLOR(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor
{
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

func UIColorFromRGB(hexRGB: UInt32) -> UIColor
{
    let redComponent = (hexRGB & 0xFF0000) >> 16
    let greenComponent = (hexRGB & 0x00FF00) >> 8
    let blueComponent = hexRGB & 0x0000FF
    
    return RGBCOLOR(r: CGFloat(redComponent), g: CGFloat(greenComponent), b: CGFloat(blueComponent))
}

//RGB颜色转换（16进制）+ 透明度  --add by gyanping
func UIColorFromRGBAlpha(hexRGB: UInt32, alphas: CGFloat) -> UIColor
{
    let redComponent = (hexRGB & 0xFF0000) >> 16
    let greenComponent = (hexRGB & 0x00FF00) >> 8
    let blueComponent = hexRGB & 0x0000FF
    
    return RGBA(r: CGFloat(redComponent), g: CGFloat(greenComponent), b: CGFloat(blueComponent),a: alphas)
}
