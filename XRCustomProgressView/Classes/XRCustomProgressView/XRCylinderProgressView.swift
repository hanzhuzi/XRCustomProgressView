//
//  XRCylinderProgressView.swift
//  XRCustomProgressView
//
//  Created by xuran on 2017/10/1.
//  Copyright © 2017年 xuran. All rights reserved.
//

import UIKit

class XRCylinderProgressView: UIView {

    lazy var progressLayer: CAShapeLayer = CAShapeLayer()
    
    struct ProgressLayerConst {
        static let progressLayerAnimationKey: String = "progressLayerAnimationKey"
        static let progressLayerAnimationKeyPath: String = "strokeEnd"
        static let progressLayerBackgroundColorCGColor =  UIColorFromRGB(hexRGB: 0x1b1d1f).cgColor
        static let progressLayerStrokeColorCGColor = UIColorFromRGB(hexRGB: 0xb18b56).cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        progressLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.layer.addSublayer(progressLayer)
        
        let progressLayerPath = UIBezierPath()
        progressLayerPath.move(to: CGPoint(x: 0, y: self.frame.size.height * 0.5))
        progressLayerPath.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height * 0.5))
        
        progressLayer.path = progressLayerPath.cgPath
        progressLayer.lineWidth = self.progressLayer.frame.size.height
        progressLayer.backgroundColor = ProgressLayerConst.progressLayerBackgroundColorCGColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = ProgressLayerConst.progressLayerStrokeColorCGColor
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        progressLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        let progressLayerPath = UIBezierPath()
        progressLayerPath.move(to: CGPoint(x: 0, y: self.frame.size.height * 0.5))
        progressLayerPath.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height * 0.5))
        
        progressLayer.path = progressLayerPath.cgPath
        progressLayer.lineWidth = self.progressLayer.frame.size.height
        progressLayer.backgroundColor = ProgressLayerConst.progressLayerBackgroundColorCGColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = ProgressLayerConst.progressLayerStrokeColorCGColor
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 0
    }
    
    // 开始执行动画
    // progress: 取值[0.0 1.0].
    func animateForProgressView(duration: CFTimeInterval = 1.0, delayTime: CFTimeInterval = 0.0 , progress: CGFloat, animate: Bool = true) {
        
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 0
        
        if animate {
            
            if nil != progressLayer.animation(forKey: ProgressLayerConst.progressLayerAnimationKey) {
                progressLayer.removeAnimation(forKey: ProgressLayerConst.progressLayerAnimationKey)
            }
            
            let basicAnima = CABasicAnimation(keyPath: ProgressLayerConst.progressLayerAnimationKeyPath)
            basicAnima.fromValue = 0.0
            basicAnima.toValue = progress
            basicAnima.duration = duration
            basicAnima.repeatCount = 1
            basicAnima.autoreverses = false
            basicAnima.isRemovedOnCompletion = false
            basicAnima.fillMode = kCAFillModeForwards
            basicAnima.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            basicAnima.beginTime = CACurrentMediaTime() + delayTime
            progressLayer.add(basicAnima, forKey: ProgressLayerConst.progressLayerAnimationKey)
        }
        else {
            progressLayer.strokeEnd = progress
        }
    }
    
}

