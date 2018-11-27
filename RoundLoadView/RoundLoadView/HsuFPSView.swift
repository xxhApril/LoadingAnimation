//
//  HsuFPSView.swift
//  RoundLoadView
//
//  Created by Hsu on 2018/11/26.
//  Copyright © 2018 许向华. All rights reserved.
//

/// FPS展示视图

import UIKit

// MARK: - FPS展示视图
class HsuFPSView: NSObject {
    /// 展示
    private var fpsLabel: UILabel?
    private var window: UIWindow?
    /// 计时器
    private let handler = HsuFPSHandler.shared
    /// 单例
    static let shared = HsuFPSView()
    private override init() {
        super.init()
        if fpsLabel == nil {
            fpsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        }
        fpsLabel?.textAlignment = .center
        fpsLabel?.backgroundColor = UIColor.orange
        fpsLabel?.font = UIFont.systemFont(ofSize: 16)
        fpsLabel?.alpha = 0.7
        fpsLabel?.textColor = UIColor.white
        fpsLabel?.clipsToBounds = true
        fpsLabel?.layer.cornerRadius = 5
        
        if window == nil {
            window = UIWindow(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        }
        
        let vc = UIViewController()
        window?.rootViewController = vc
        
        window?.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 64)
        window?.windowLevel = UIWindow.Level.alert + 1
        window?.clipsToBounds = true
        window?.layer.cornerRadius = 10
        window?.addSubview(fpsLabel!)
        window?.makeKeyAndVisible()
        
        let panGes = UIPanGestureRecognizer(target: self, action: #selector(handlePanGes(pan:)))
        window?.isUserInteractionEnabled = true
        window?.addGestureRecognizer(panGes)
    }
    
    /// 开启监测
    func startMonitoring() {
        // 开启监测
        handler.startMonitoring()
        handler.fpsBlock = { fps in
            self.fpsLabel?.text = String(format: "%.2f", fps)
        }
    }
    
    /// 暂停监测
    func pauseMonitoring() {
        handler.pauseMonitoring()
    }
    
    /// 移除监测
    func removeMonitoring() {
        handler.removeMonitoring()
    }
    
    
    /// 处理拖动手势
    ///
    /// - Parameter pan: 手势
    @objc private func handlePanGes(pan: UIPanGestureRecognizer) {
        let translation = pan.translation(in: window)
        window?.center = CGPoint(x: (window?.center.x ?? 0) + translation.x, y: (window?.center.y ?? 0) + translation.y)
        pan.setTranslation(CGPoint.zero, in: window)
    }
    
    /// 关闭FPS视图
    func closeFPSView() {
        window?.resignKey()
        window = nil
    }
}


// MARK: - FPS 逻辑
class HsuFPSHandler: NSObject {
    /// 检测过程中FPS回调
    var fpsBlock: ((Double) -> Void)?
    
    /// 计时器
    private var displayLink: CADisplayLink?
    /// 1秒刷新次数
    private var count: Int = 0
    /// 开始时屏幕渲染的时间点
    private var beginTime: TimeInterval = 0
    
    /// 单例
    fileprivate static let shared = HsuFPSHandler()
    private override init() {
        super.init()
        if displayLink == nil {
            displayLink = CADisplayLink(target: self, selector: #selector(displayLinkTick(link:)))
        }
        displayLink?.isPaused = true
        displayLink?.add(to: RunLoop.current, forMode: .common)
    }
    
    /// 开始监测
    fileprivate func startMonitoring() {
        displayLink?.isPaused = false
    }
    
    /// 暂停监测
    fileprivate func pauseMonitoring() {
        displayLink?.isPaused = true
    }
    
    /// 移除监测
    fileprivate func removeMonitoring() {
        pauseMonitoring()
        displayLink?.remove(from: RunLoop.current, forMode: RunLoop.Mode.common)
        displayLink?.invalidate()
    }
    
    /// 这个方法的执行频率和当前屏幕刷新频率是一样的，屏幕每渲染刷新一次，就执行一次，那么一秒的时长执行刷新的次数就是当前的FPS值
    ///
    /// - Parameter link: 计时器
    @objc private func displayLinkTick(link: CADisplayLink) {
        // 初始化屏幕渲染时间
        if beginTime == 0 {
            beginTime = link.timestamp
            return
        }
        
        // 刷新次数累加
        count += 1
        // 时差
        let interval = link.timestamp - beginTime
        if interval < 1 {
            // 不足1秒，继续统计刷新次数
            return
        }
        // 刷新频率
        let fps = Double(count) / interval
        // 回调
        fpsBlock?(fps)
        // 1 秒后初始化时间和次数，从新开始监测
        beginTime = link.timestamp
        count = 0
    }
    
    deinit {
        removeMonitoring()
    }
}
