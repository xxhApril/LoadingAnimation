//
//  HsuBallRoatationView.swift
//  RoundLoadView
//
//  Created by Hsu on 2018/9/20.
//  Copyright © 2018年 许向华. All rights reserved.
//

/// 多球旋转视图
import UIKit

extension UIView {
    /// 添加加载动画
    ///
    /// - Parameters:
    ///   - title: 描述文字
    ///   - enable: 加载期间是否可执行其他操作
    func makeLoading(title: String? = "", enable: Bool = false) {
        // 加载图基本展示
        var roundView: HsuBallRoatationView?
        var needInitRoundView = true
        var needInitCoverView = true
        var needInitTitleView = true
        subviews.forEach { (v) in
            if v.tag == 10001 {
                needInitRoundView = false
            }
            if v.tag == 10002 {
                needInitCoverView = false
            }
            if v.tag == 10003 {
                needInitTitleView = false
            }
        }
        if needInitRoundView {
            roundView = HsuBallRoatationView(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        }
        guard let rView = roundView else {
            return
        }
        rView.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        rView.tag = 10001
        addSubview(rView)
        bringSubviewToFront(rView)
        rView.backgroundColor = UIColor.clear
        
        // 如果有文本
        if title != nil && !title!.isEmpty && needInitTitleView {
            let fontSize:CGFloat = 16
            let strSize = (title! as NSString).boundingRect(with: CGSize(width: bounds.width - 50, height: 15), options: [], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size
            
            let titleView = UIView(frame: CGRect(x: 0, y: 0, width: strSize.width > 100 ? strSize.width + 25 : 100, height: 80))
            titleView.backgroundColor = UIColor.groupTableViewBackground
            titleView.clipsToBounds = true
            titleView.layer.cornerRadius = 10
            titleView.center =  CGPoint(x: bounds.width / 2, y: bounds.height / 2)
            addSubview(titleView)
            bringSubviewToFront(titleView)
            titleView.tag = 10003
            
            rView.removeFromSuperview()
            rView.center = CGPoint(x: titleView.bounds.width / 2, y: 20)
            titleView.addSubview(rView)
            
            // 添加标题
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: strSize.width, height: 20))
            label.text = title
            label.font = UIFont.systemFont(ofSize: fontSize)
            label.backgroundColor = UIColor.clear
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            titleView.addSubview(label)
            label.center = CGPoint(x: titleView.bounds.width / 2, y: titleView.bounds.height - 18)
        }
        
        // 如果不可点击，则在高层添加遮罩
        if !enable {
            if needInitCoverView {
                let coverView = UIControl(frame: bounds)
                coverView.isEnabled = true
                coverView.tag = 10002
                addSubview(coverView)
                bringSubviewToFront(coverView)
            }
        }
    }
    
    /// 移除加载动画
    func dismissLoading() {
        subviews.forEach { (v) in
            if v.tag == 10001 {
                v.removeFromSuperview()
            }
            if v.tag == 10002 {
                v.removeFromSuperview()
            }
            if v.tag == 10003 {
                v.removeFromSuperview()
            }
        }
    }
}

// MARK: - 专门为充值写一个Loading
extension UIView {
    /// 添加加载动画
    ///
    /// - Parameters:
    ///   - title: 描述文字
    ///   - enable: 加载期间是否可执行其他操作
    func makePurchase(title: String? = "", enable: Bool = false) {
        // 加载图基本展示
        var roundView: HsuBallRoatationView?
        var needInitRoundView = true
        var needInitCoverView = true
        var needInitTitleView = true
        subviews.forEach { (v) in
            if v.tag == 10001 {
                needInitRoundView = false
            }
            if v.tag == 10002 {
                needInitCoverView = false
            }
            if v.tag == 10003 {
                needInitTitleView = false
            }
        }
        if needInitRoundView {
            roundView = HsuBallRoatationView(frame: CGRect(x: 0, y: 0, width: bounds.width / 2, height: 40))
        }
        guard let rView = roundView else {
            return
        }
        rView.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        rView.tag = 10001
        addSubview(rView)
        bringSubviewToFront(rView)
        rView.backgroundColor = UIColor.clear
        
        rView.setAnimatonDistance(distance: 50)
        rView.setBallRadius(radius: 15)
        rView.setAnimationDurtion(durtion: 1.5)
        rView.startAnimation()
        
        // 如果有文本
        if title != nil && !title!.isEmpty && needInitTitleView {
            let fontSize:CGFloat = 16
            let strSize = (title! as NSString).boundingRect(with: CGSize(width: bounds.width - 50, height: 15), options: [], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size
            
            let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 240, height: 120))
            titleView.backgroundColor = UIColor.black.withAlphaComponent(0.75)
            titleView.clipsToBounds = true
            titleView.layer.cornerRadius = 10
            titleView.center =  CGPoint(x: bounds.width / 2, y: bounds.height / 2 - 40)
            addSubview(titleView)
            bringSubviewToFront(titleView)
            titleView.tag = 10003
            
            rView.removeFromSuperview()
            rView.center = CGPoint(x: titleView.bounds.width / 2, y: 30)
            titleView.addSubview(rView)
            
            // 添加标题
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: strSize.width, height: 20))
            label.text = title
            label.font = UIFont.systemFont(ofSize: fontSize)
            label.backgroundColor = UIColor.clear
            label.textColor = UIColor.white
            label.textAlignment = .center
            titleView.addSubview(label)
            label.center = CGPoint(x: titleView.bounds.width / 2, y: titleView.bounds.height - 32)
        }
        
        // 如果不可点击，则在高层添加遮罩
        if !enable {
            if needInitCoverView {
                let coverView = UIControl(frame: bounds)
                coverView.isEnabled = true
                addSubview(coverView)
                coverView.tag = 10002
                bringSubviewToFront(coverView)
            }
        }

    }
}

class HsuBallRoatationView: UIView {
    // MARK: - Private Properties
    /// 设置默认颜色
    private let FirstBallColor = UIColor(red: 255 / 255.0, green: 120 / 255.0, blue: 120 / 255.0, alpha: 1.0)
    private let SecondBallColor = UIColor(red: 255 / 255.0, green: 217 / 255.0, blue: 81 / 255.0, alpha: 1.0)
    private let ThirdBallColor = UIColor(red: 87 / 255.0, green: 200 / 255.0, blue: 255 / 255.0, alpha: 1.0)
    /// 设置球默认半径
    private let BallRadiusDefault: CGFloat = 8
    /// 设置默认运动半径
    private let AnimationDistanceDefault: CGFloat = 30
    /// 设置默认动画时长
    private let AnimationDurtionDefault: TimeInterval = 1.2
    
    /// 半径
    private var radius: CGFloat = 0
    /// 动画时长
    private var animationDurtion: TimeInterval = 0
    /// 轨迹长度
    private var distance: CGFloat = 0
    /// 中心点
    private var centerPoint = CGPoint(x: 0, y: 0)
    /// 第一个球layer
    lazy var oneLayer: CAShapeLayer = {
       let layer = CAShapeLayer()
        layer.frame = bounds
        layer.path = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true).cgPath
        return layer
    }()
    /// 第二个Layer
    private lazy var twoLayer: CAShapeLayer = {
       let layer = CAShapeLayer()
        layer.frame = bounds
        layer.path = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true).cgPath
        return layer
    }()
    /// 第三个layer
    private lazy var threeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.frame = bounds
        layer.path = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true).cgPath
        return layer
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        // 初始化
        initProgressBar()
        // 设置球颜色
        setBallColor(firstColor: FirstBallColor, secondColor: SecondBallColor, thirdColor: ThirdBallColor)
        // 设置球半径
        setBallRadius(radius: BallRadiusDefault)
        // 设置运动半径
        setAnimatonDistance(distance: AnimationDistanceDefault)
        // 设置动画时长
        setAnimationDurtion(durtion: AnimationDurtionDefault)
        // 开启动画
        startAnimation()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    /// 设置小球半径
    func setBallRadius(radius: CGFloat) {
        self.radius = radius
        oneLayer.path = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true).cgPath
        twoLayer.path = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true).cgPath
        threeLayer.path = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true).cgPath
    }

    /// 设置三个小球颜色
    func setBallColor(firstColor: UIColor, secondColor: UIColor, thirdColor: UIColor) {
        oneLayer.fillColor = firstColor.cgColor
        twoLayer.fillColor = secondColor.cgColor
        threeLayer.fillColor = thirdColor.cgColor
    }
    
    /// 设置动画时长
    func setAnimationDurtion(durtion: TimeInterval) {
        self.animationDurtion = durtion
    }
    
    /// 设置小球移动轨迹的半径
    func setAnimatonDistance(distance: CGFloat) {
        self.distance = distance
        if distance > bounds.width || distance < 4 {
            self.distance = bounds.width / 2
        }
    }
    
    /// 开始动画
    func startAnimation() {
        stopAnimation()
        
        startOneBallAnimation()
        startTwoBallAnimation()
        startThreeBallAnimation()
    }
    
    /// 结束动画
    func stopAnimation() {
        // 不需要吧，这里又没有影响性能的
        oneLayer.removeAllAnimations()
        twoLayer.removeAllAnimations()
        threeLayer.removeAllAnimations()
    }
    
    /// 初始化进度
    private func initProgressBar() {
        animationDurtion = AnimationDurtionDefault
        radius = BallRadiusDefault
        distance = AnimationDistanceDefault
        centerPoint = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        // 添加三个Layer
        layer.addSublayer(oneLayer)
        layer.addSublayer(twoLayer)
        layer.addSublayer(threeLayer)
    }
    
    /// 开启第一个小球动画
    private func startOneBallAnimation() {
        // 旋转动画
        let transformation = CAKeyframeAnimation(keyPath: "transform.translation.z")
        transformation.values = [0, 1, 0, 0]
        
        // 第一个小球位移动画
        let oneFrameAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGMutablePath.init()
        path.move(to:  CGPoint(x: centerPoint.x - distance, y: centerPoint.y))
        path.addLine(to: CGPoint(x: centerPoint.x, y: centerPoint.y))
        path.addLine(to:  CGPoint(x: centerPoint.x + distance, y: centerPoint.y))
        path.addLine(to:  CGPoint(x: centerPoint.x - distance, y: centerPoint.y))
        oneFrameAnimation.path = path
        oneFrameAnimation.keyTimes = [0, 0.333333, 0.666666, 1.0] as [NSNumber]
        
        // 第一个小球缩放动画
        let oneScaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        oneScaleAnimation.values = [0.7, 1.2, 0.7, 0.7]
        
        // 第一个小球透明动画
        let oneOpactiyAniamtion = CAKeyframeAnimation(keyPath: "opacity")
        
        // 组合动画
        let oneGroup = CAAnimationGroup()
        oneGroup.animations = [transformation, oneFrameAnimation, oneScaleAnimation, oneOpactiyAniamtion]
        oneGroup.duration = self.animationDurtion
        oneGroup.repeatCount = HUGE
        oneLayer.add(oneGroup, forKey: "oneGroup")
    }
    
    /// 开始第二个小球动画
    private func startTwoBallAnimation() {
        // 旋转动画
        let transformation = CAKeyframeAnimation(keyPath: "transform.translation.z")
        transformation.values = [1, 0, 0, 1]
        
        // 第二个小球位移动画
        let twoFrameAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGMutablePath.init()
        path.move(to: centerPoint)
        path.addLine(to: CGPoint(x: centerPoint.x + distance, y: centerPoint.y))
        path.addLine(to: CGPoint(x: centerPoint.x - distance, y: centerPoint.y))
        path.addLine(to: centerPoint)
        twoFrameAnimation.path = path
        twoFrameAnimation.keyTimes = [0, 1.0 / 3, 2.0 / 3, 1.0] as [NSNumber]
        
        // 第二个小球缩放动画
        let twoScaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        twoScaleAnimation.values = [1.0, 0.7, 0.7, 1.0]
        
        // 第二个小球透明动画
        let twoOpactiyAniamtion = CAKeyframeAnimation(keyPath: "opacity")
        
        // 组合动画
        let twoGroup = CAAnimationGroup()
        twoGroup.animations = [transformation, twoFrameAnimation, twoScaleAnimation, twoOpactiyAniamtion]
        twoGroup.duration = self.animationDurtion
        twoGroup.repeatCount = HUGE
        twoLayer.add(twoGroup, forKey: "twoGroup")
    }
    
    /// 开始第三个球动画
    private func startThreeBallAnimation() {
        // 旋转动画
        let transformation = CAKeyframeAnimation(keyPath: "transform.translation.z")
        transformation.values = [0, 0, 1, 0]
        
        // 第三个小球位移动画
        let threeFrameAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGMutablePath.init()
        path.move(to: CGPoint(x: centerPoint.x + distance, y: centerPoint.y))
        path.addLine(to: CGPoint(x: centerPoint.x - distance, y: centerPoint.y))
        path.addLine(to: centerPoint)
        path.addLine(to: CGPoint(x: centerPoint.x + distance, y: centerPoint.y))
        threeFrameAnimation.path = path
        threeFrameAnimation.keyTimes = [0, 1.0 / 3, 2.0 / 3, 1.0] as [NSNumber]
        
        // 第一个小球缩放动画
        let threeScaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        threeScaleAnimation.values = [0.7, 0.7, 1.0, 0.7]
        
        // 第一个小球透明动画
        let threeOpactiyAniamtion = CAKeyframeAnimation(keyPath: "opacity")
        
        // 组合动画
        let threeGroup = CAAnimationGroup()
        threeGroup.animations = [transformation, threeFrameAnimation, threeScaleAnimation, threeOpactiyAniamtion]
        threeGroup.duration = self.animationDurtion
        threeGroup.repeatCount = HUGE
        threeLayer.add(threeGroup, forKey: "threeGroup")
    }
}
