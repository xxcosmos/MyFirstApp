//
//  WUSTNoticeDetailController.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/14.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class WUSTNoticeDetailController: XYWebViewController {
    
    var text: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.title = "通知详情"
        self.webView.loadHTMLString(text!, baseURL: nil)
        SVProgressHUD.show()
    }
    
    convenience init(text: String){
        self.init()
        self.text = text
    }
    
}

