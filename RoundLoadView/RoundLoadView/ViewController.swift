//
//  ViewController.swift
//  RoundLoadView
//
//  Created by Hsu on 2018/9/20.
//  Copyright © 2018年 许向华. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var fontLabel: UILabel!
    private let Text = "今天是个好天气"
    override func viewDidLoad() {
        super.viewDidLoad()
        fontLabel.text = Text
        HsuFPSView.shared.startMonitoring()
        
        HsuFontHandler.shared.setupFont()
    }

    @IBAction func c1(_ sender: Any) {
        view.makeLoading(title: nil, enable: true)
    }
    
    
    @IBAction func c5(_ sender: Any) {
        view.makeLoading(title: "请求最新数据...", enable: true)
    }
    
    @IBAction func c7(_ sender: Any) {
        view.makePurchase(title: "连接App Store，请勿退出...", enable: false)
    }
    
    
    @IBAction func c2(_ sender: Any) {
        view.makeLoading(title: nil, enable: false)
    }
    
    @IBAction func c3(_ sender: Any) {
        view.dismissLoading()
    }
    
    // 特殊字体
    @IBAction func changeFont(_ sender: Any) {
        fontLabel.font = UIFont(name: HsuFontHandler.shared.fontNameString ?? "", size: 20) ?? UIFont.systemFont(ofSize: 20)
    }
    
    // 正常字体
    @IBAction func normalFont(_ sender: Any) {
        fontLabel.font = UIFont.systemFont(ofSize: 20)
    }
    
}

