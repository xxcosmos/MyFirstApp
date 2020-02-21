//
//  XYWebViewController.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/15.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class XYWebViewController: XYBaseViewController {
    
    lazy var webView: WKWebView = {
        let webView =  WKWebView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - TabBarHeight))
        webView.navigationDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        webView.snp.makeConstraints { $0.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)}
    }
    
    deinit {
        webView.stopLoading()
        webView.navigationDelegate = nil
        
    }
    
    
}

extension XYWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        
        if (navigationAction.targetFrame == nil) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        
        // To connnect app store
        if url.host == "itunes.apple.com", UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            decisionHandler(.cancel)
            return
        }
              
        print(url.scheme ?? "")
        switch url.scheme {
        case "http","https":
            navigationController?.pushViewController(XYSafariViewController(url: url), animated: true)
            decisionHandler(.allow)
        case "tel","sms","mailto",.none:
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
             decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
            
        }
    }
}
