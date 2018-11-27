//
//  HsuFontHandler.swift
//  RoundLoadView
//
//  Created by Hsu on 2018/11/27.
//  Copyright © 2018 许向华. All rights reserved.
//

/// 字体更换

import UIKit

class HsuFontHandler: NSObject {
    var fontNameString: String?
    
    static let shared = HsuFontHandler()
    private override init() {
        super.init()
    }
    
    /// 设置字体
    func setupFont() {
        let path = Bundle.main.path(forResource: "XiaoweiLogo", ofType: "otf")
        if path == nil {
            print("未找到本地字体资源")
            return
        }
        fontNameString = customFontWith(path: path!, size: 18)
    }
    
    /// 根据路径资源获取字体
    ///
    /// - Parameters:
    ///   - path: 资源地址
    ///   - size: 字体大小
    /// - Returns: 字体名
    private func customFontWith(path: String, size: CGFloat) -> String? {
        let fontUlr = URL(fileURLWithPath: path)
        let fontData = CGDataProvider(url: fontUlr as CFURL)
        guard let fontDataProvider = fontData else {
            print("字体资源加载失败")
            return nil
        }
        
        let fontRef = CGFont(fontDataProvider)
        let error: UnsafeMutablePointer<Unmanaged<CFError>?>? = nil
        
        guard let fontReff = fontRef else {
            print("字体转换失败")
            return nil
        }
        
        // 注册字体
        let regiester = CTFontManagerRegisterGraphicsFont(fontReff, error)
        if !regiester {
            print("字体注册失败")
            return nil
        }
        
        // 字体名
        guard let fontName = fontReff.fullName else {
            print("获取字体失败")
            return nil
        }
        
        return fontName as String
    }
}
