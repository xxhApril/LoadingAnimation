//
//  ViewController.swift
//  RoundLoadView
//
//  Created by Hsu on 2018/9/20.
//  Copyright © 2018年 许向华. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
}

