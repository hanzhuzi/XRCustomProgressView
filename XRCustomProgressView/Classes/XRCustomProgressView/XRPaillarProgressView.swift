//
//  XRPaillarProgressView.swift
//  XRCustomProgressView
//
//  Created by xuran on 2017/10/1.
//  Copyright © 2017年 xuran. All rights reserved.
//

import UIKit

class XRPaillarProgressView: UIView {

    lazy var progressLayer: CAShapeLayer = CAShapeLayer()
    lazy var precentLbl: UILabel = UILabel(frame: CGRect.zero)
    
    var progress: CGFloat = 0
    var stepProgress: CGFloat = 0
    var duration: Double = 1.0
    var timer: Timer?
    
    struct ProgressLayerConst {
        static let progressLayerAnimationKey: String = "progressLayerAnimationKey"
        static let progressLayerAnimationKeyPath: String = "strokeEnd"
        static let progressLayerBackgroundColorCGColor =  UIColorFromRGB(hexRGB: 0xFFFFFF).cgColor
        static let progressLayerStrokeColorCGColor = UIColorFromRGB(hexRGB: 0xF2EBDB).cgColor
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
        progressLayer.borderColor = UIColorFromRGB(hexRGB: 0xAF9A84).cgColor
        progressLayer.borderWidth = 1.0
        progressLayer.cornerRadius = 9.0
        progressLayer.masksToBounds = true
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 0
        
        precentLbl.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.addSubview(precentLbl)
        
        precentLbl.textColor = UIColorFromRGB(hexRGB: 0xAF9A84)
        precentLbl.textAlignment = .center
        precentLbl.font = UIFont.systemFont(ofSize: 11.0)
        precentLbl.text = "剩余60%"
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
        
        precentLbl.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    func startTimer() {
        
        if nil == timer {
            timer = Timer.scheduledTimer(timeInterval: duration / 10.0, target: self, selector: #selector(self.updatePrecent), userInfo: nil, repeats: true)
            RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
        }
    }
    
    func stopTimer() {
        
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc func updatePrecent() {
        
        let step =  self.progress / CGFloat(10.0)
        stepProgress = stepProgress + step
        if stepProgress >= self.progress {
            stepProgress = self.progress
            let precentText: String = "\(stepProgress * 100)%"
            precentLbl.text = precentText
            self.stopTimer()
        }
        else {
            let precentText: String = "\(stepProgress * 100)%"
            precentLbl.text = precentText
        }
    }
    
    // 开始执行动画
    // progress: 取值[0.0 1.0].
    func animateForProgressView(duration: CFTimeInterval = 1.0, delayTime: CFTimeInterval = 0.0 , progress: CGFloat, animate: Bool = true) {
        
        self.progress = progress
        self.stepProgress = 0.0
        self.duration = duration
        
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
            
            self.startTimer()
        }
        else {
            progressLayer.strokeEnd = progress
        }
    }
    
}
