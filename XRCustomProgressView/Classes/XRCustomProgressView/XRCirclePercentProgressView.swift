//
//  XRCirclePercentProgressView.swift
//  XRCustomProgressView
//
//  Created by xuran on 2017/10/1.
//  Copyright © 2017年 xuran. All rights reserved.
//

import UIKit

class XRCirclePercentProgressView: UIView {

    lazy var precentLbl: UILabel = UILabel(frame: CGRect.zero)
    lazy var yearEarningsLbl: UILabel = UILabel(frame: CGRect.zero)
    lazy var circlePlateLayer: CAShapeLayer = CAShapeLayer()
    lazy var circleProgressLayer: CAShapeLayer = CAShapeLayer()
    lazy var indicatorLayer: CAShapeLayer = CAShapeLayer()
    
    var precent: CGFloat = 0
    var stepPrecent: CGFloat = 0
    var duration: Double = 1.0
    var timer: Timer?
    
    // Const defines
    struct CustomCircleProgessConst {
        static let indicatorLayerWidth: CGFloat = 2.0
        // MARK: - 注‘如果设置CABasicAnimation的beginTime为CustomCircleProgessConst.
        // indicatorLayerBeginTime则滑动UITableViewCell时动画将不会重复执行，问题比较棘手在此处作为标记’
        // static let indicatorLayerBeginTime: CFTimeInterval = CACurrentMediaTime() + 0.0
        static let circlePlateLayerColorCGColor = UIColorFromRGB(hexRGB: 0xCCCCCC).cgColor
        static let circleProgressLayerColorCGColor = UIColorFromRGB(hexRGB: 0xB3282C).cgColor
        
        static let circleProgessLayerAnimationKeyPath: String = "strokeEnd"
        static let circleProgessLayerAnimationKey: String = "circleProgessLayerAnimationKey"
        static let indicatorLayerAnimationKeyPath: String = "transform.rotation"
        static let indicatorLayerAnimationKey: String = "indicatorLayerAnimationKey"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        circlePlateLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.layer.addSublayer(circlePlateLayer)
        
        let platePath = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.5), radius: 60, startAngle: CGFloat(Double.pi / 180.0) * 135.0, endAngle: CGFloat(Double.pi / 180.0) * 45.0, clockwise: true)
        circlePlateLayer.path = platePath.cgPath
        circlePlateLayer.fillColor = UIColor.clear.cgColor
        circlePlateLayer.strokeColor = CustomCircleProgessConst.circlePlateLayerColorCGColor
        circlePlateLayer.lineWidth = 8.0
        circlePlateLayer.lineDashPattern = [2, 3]
        
        circleProgressLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.layer.addSublayer(circleProgressLayer)
        
        let progressPath = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.5), radius: 70, startAngle: CGFloat(Double.pi / 180.0 * 135.0), endAngle: CGFloat(Double.pi / 180.0 * 45.0), clockwise: true)
        circleProgressLayer.path = progressPath.cgPath
        circleProgressLayer.fillColor = UIColor.clear.cgColor
        circleProgressLayer.strokeColor = CustomCircleProgessConst.circleProgressLayerColorCGColor
        circleProgressLayer.lineWidth = CustomCircleProgessConst.indicatorLayerWidth
        circleProgressLayer.strokeStart = 0.0
        circleProgressLayer.strokeEnd = 0.0
        
        indicatorLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.layer.addSublayer(indicatorLayer)
        
        let indicatorPath = UIBezierPath()
        
        let distanceX: CGFloat = 70.0 * cos(CGFloat(Double.pi * 0.25))
        let distanceY: CGFloat = 70.0 * sin(CGFloat(Double.pi * 0.25))
        let indicatorX: CGFloat = self.frame.size.width * 0.5 - distanceX + 0.5
        let indicatorY: CGFloat = self.frame.size.height * 0.5 + distanceY
        
        // 当斜边为8
        let startX: CGFloat = indicatorX - 8.0 * cos(CGFloat(Double.pi * 0.25))
        let startY: CGFloat = indicatorY + 8.0 * sin(CGFloat(Double.pi * 0.25))
        
        indicatorPath.move(to: CGPoint(x: startX, y: startY))
        indicatorPath.addLine(to: CGPoint(x: indicatorX, y: indicatorY))
        indicatorLayer.path = indicatorPath.cgPath
        indicatorLayer.lineWidth = CustomCircleProgessConst.indicatorLayerWidth
        indicatorLayer.fillColor = UIColor.clear.cgColor
        indicatorLayer.strokeColor = CustomCircleProgessConst.circleProgressLayerColorCGColor
        
        precentLbl.frame = CGRect(x: self.frame.size.width * 0.5 - 60.0, y: self.frame.size.height * 0.5 - 60.0, width: 60.0 * 2, height: 60.0 * 2)
        self.addSubview(precentLbl)
        
        precentLbl.textColor = UIColorFromRGB(hexRGB: 0x000000)
        precentLbl.textAlignment = .center
        precentLbl.font = UIFont.systemFont(ofSize: 30.0)
        
        let precentText: String = "0%"
        let precentStyle = NSMutableParagraphStyle()
        precentStyle.alignment = .center
        
        let attributesPrecentText = NSMutableAttributedString(string: precentText, attributes: [NSAttributedStringKey.foregroundColor : UIColorFromRGB(hexRGB: 0x000000), NSAttributedStringKey.font : UIFont.systemFont(ofSize: 30.0), NSAttributedStringKey.paragraphStyle : precentStyle])
        attributesPrecentText.addAttributes([NSAttributedStringKey.foregroundColor : UIColorFromRGB(hexRGB: 0x000000), NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20.0), NSAttributedStringKey.paragraphStyle : precentStyle], range: (precentText as NSString).range(of: "%"))
        precentLbl.attributedText = attributesPrecentText
        
        let cosPlateXDistance: CGFloat = 60.0 * cos(CGFloat(Double.pi * 0.25))
        let sinPlateYDistance: CGFloat = 60.0 * sin(CGFloat(Double.pi * 0.25))
        yearEarningsLbl.frame = CGRect(x: self.frame.size.width * 0.5 - cosPlateXDistance, y: self.frame.size.height * 0.5 + sinPlateYDistance - 15.0, width: cosPlateXDistance * 2.0, height: 30.0)
        yearEarningsLbl.textColor = UIColorFromRGB(hexRGB: 0xCCCCCC)
        yearEarningsLbl.textAlignment = .center
        yearEarningsLbl.font = UIFont.systemFont(ofSize: 13)
        yearEarningsLbl.text = "年化收益率"
        self.addSubview(yearEarningsLbl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circlePlateLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        let platePath = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.5), radius: 60, startAngle: CGFloat(Double.pi / 180.0) * 135.0, endAngle: CGFloat(Double.pi / 180.0) * 45.0, clockwise: true)
        circlePlateLayer.path = platePath.cgPath
        circlePlateLayer.fillColor = UIColor.clear.cgColor
        circlePlateLayer.strokeColor = CustomCircleProgessConst.circlePlateLayerColorCGColor
        circlePlateLayer.lineWidth = 8.0
        circlePlateLayer.lineDashPattern = [2, 3]
        
        circleProgressLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        let progressPath = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.5), radius: 70, startAngle: CGFloat(Double.pi / 180.0 * 135.0), endAngle: CGFloat(Double.pi / 180.0 * 45.0), clockwise: true)
        circleProgressLayer.path = progressPath.cgPath
        circleProgressLayer.fillColor = UIColor.clear.cgColor
        circleProgressLayer.strokeColor = CustomCircleProgessConst.circleProgressLayerColorCGColor
        circleProgressLayer.lineWidth = CustomCircleProgessConst.indicatorLayerWidth
        circleProgressLayer.strokeStart = 0.0
        circleProgressLayer.strokeEnd = 0.0
        
        indicatorLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        let indicatorPath = UIBezierPath()
        
        let distanceX: CGFloat = 70.0 * cos(CGFloat(Double.pi * 0.25))
        let distanceY: CGFloat = 70.0 * sin(CGFloat(Double.pi * 0.25))
        let indicatorX: CGFloat = self.frame.size.width * 0.5 - distanceX + 0.5
        let indicatorY: CGFloat = self.frame.size.height * 0.5 + distanceY
        
        // 当斜边为8
        let startX: CGFloat = indicatorX - 8.0 * cos(CGFloat(Double.pi * 0.25))
        let startY: CGFloat = indicatorY + 8.0 * sin(CGFloat(Double.pi * 0.25))
        
        indicatorPath.move(to: CGPoint(x: startX, y: startY))
        indicatorPath.addLine(to: CGPoint(x: indicatorX, y: indicatorY))
        indicatorLayer.path = indicatorPath.cgPath
        indicatorLayer.lineWidth = CustomCircleProgessConst.indicatorLayerWidth
        indicatorLayer.fillColor = UIColor.clear.cgColor
        indicatorLayer.strokeColor = CustomCircleProgessConst.circleProgressLayerColorCGColor
        
        precentLbl.frame = CGRect(x: self.frame.size.width * 0.5 - 60.0, y: self.frame.size.height * 0.5 - 60.0, width: 60.0 * 2, height: 60.0 * 2)
        let cosPlateXDistance: CGFloat = 60.0 * cos(CGFloat(Double.pi * 0.25))
        let sinPlateYDistance: CGFloat = 60.0 * sin(CGFloat(Double.pi * 0.25))
        yearEarningsLbl.frame = CGRect(x: self.frame.size.width * 0.5 - cosPlateXDistance, y: self.frame.size.height * 0.5 + sinPlateYDistance - 15.0, width: cosPlateXDistance * 2.0, height: 30.0)
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
        
        if let doubleNum = Double(String(format: "%.2f", self.precent)) {
            self.precent = CGFloat(doubleNum)
        }
        let step =  self.precent / CGFloat(10.0)
        stepPrecent = stepPrecent + step
        if stepPrecent >= self.precent {
            stepPrecent = self.precent
            let precentText: String = "\(stepPrecent * 100)%"
            
            let precentStyle = NSMutableParagraphStyle()
            precentStyle.alignment = .center
            let attributesPrecentText = NSMutableAttributedString(string: precentText, attributes: [NSAttributedStringKey.foregroundColor : UIColorFromRGB(hexRGB: 0x000000), NSAttributedStringKey.font : UIFont.systemFont(ofSize: 30.0), NSAttributedStringKey.paragraphStyle : precentStyle])
            attributesPrecentText.addAttributes([NSAttributedStringKey.foregroundColor : UIColorFromRGB(hexRGB: 0x000000), NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20.0), NSAttributedStringKey.paragraphStyle : precentStyle], range: (precentText as NSString).range(of: "%"))
            precentLbl.attributedText = attributesPrecentText
            self.stopTimer()
        }
        else {
            let precentText: String = "\(stepPrecent * 100)%"
            
            let precentStyle = NSMutableParagraphStyle()
            precentStyle.alignment = .center
            let attributesPrecentText = NSMutableAttributedString(string: precentText, attributes: [NSAttributedStringKey.foregroundColor : UIColorFromRGB(hexRGB: 0x000000), NSAttributedStringKey.font : UIFont.systemFont(ofSize: 30.0), NSAttributedStringKey.paragraphStyle : precentStyle])
            attributesPrecentText.addAttributes([NSAttributedStringKey.foregroundColor : UIColorFromRGB(hexRGB: 0x000000), NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20.0), NSAttributedStringKey.paragraphStyle : precentStyle], range: (precentText as NSString).range(of: "%"))
            precentLbl.attributedText = attributesPrecentText
        }
    }
    
    // begin progress animation
    func beginProgressAnimateWithPrecent(precent: CGFloat, duration: Double = 1.0, delayTime: CFTimeInterval = 0.0, animate: Bool = true) {
        
        self.precent = precent
        self.stepPrecent = 0.0
        self.duration = duration
        
        circleProgressLayer.strokeStart = 0.0
        circleProgressLayer.strokeEnd = 0.0
        
        if animate {
            
            if let _ = circleProgressLayer.animation(forKey: CustomCircleProgessConst.circleProgessLayerAnimationKey) {
                circleProgressLayer.removeAnimation(forKey: CustomCircleProgessConst.circleProgessLayerAnimationKey)
            }
            
            if let _ = indicatorLayer.animation(forKey: CustomCircleProgessConst.indicatorLayerAnimationKey) {
                indicatorLayer.removeAnimation(forKey: CustomCircleProgessConst.indicatorLayerAnimationKey)
            }
            
            let basicAnima = CABasicAnimation(keyPath: CustomCircleProgessConst.circleProgessLayerAnimationKeyPath)
            basicAnima.fromValue = 0.0
            basicAnima.toValue = precent
            basicAnima.duration = self.duration
            basicAnima.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            basicAnima.repeatCount = 1
            basicAnima.isRemovedOnCompletion = false
            basicAnima.fillMode = kCAFillModeForwards
            basicAnima.autoreverses = false
            basicAnima.beginTime = CACurrentMediaTime() + delayTime
            circleProgressLayer.add(basicAnima, forKey: CustomCircleProgessConst.circleProgessLayerAnimationKey)
            
            let trans3DAnima = CABasicAnimation(keyPath: CustomCircleProgessConst.indicatorLayerAnimationKeyPath)
            trans3DAnima.fromValue = 0
            trans3DAnima.toValue = CGFloat(Double.pi / 180.0 * 270.0 * Double(precent))
            trans3DAnima.duration = self.duration
            trans3DAnima.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            trans3DAnima.repeatCount = 1
            trans3DAnima.isRemovedOnCompletion = false
            trans3DAnima.fillMode = kCAFillModeForwards
            trans3DAnima.autoreverses = false
            trans3DAnima.beginTime = CACurrentMediaTime() + delayTime
            indicatorLayer.add(trans3DAnima, forKey: CustomCircleProgessConst.indicatorLayerAnimationKey)
            
            self.startTimer()
        }
        else {
            circleProgressLayer.strokeEnd = precent
            let transform3D = CATransform3DRotate(indicatorLayer.transform, CGFloat(Double.pi / 180.0 * 270.0 * Double(precent)), 0, 0, 1)
            indicatorLayer.transform = transform3D
        }
    }

}
