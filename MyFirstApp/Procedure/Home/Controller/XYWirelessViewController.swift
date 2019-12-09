//
//  XYWirelessViewController.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2019/12/9.
//  Copyright © 2019 xiaoyuu. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class XYWirelessViewController: XYBaseViewController {
    private var result:String? {
        didSet {
            textLabel?.text = self.result
        }
    }
    
    private var textLabel:UILabel? {
        didSet {
            self.textLabel?.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "免费校园网"
        
        textLabel = UILabel()
        textLabel?.text = result
        textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        view.addSubview(textLabel!)
        textLabel?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(50)
        })
        
        let button = UIButton(type: .custom)
        button.setTitle("连接", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.setBackgroundImage(UIColor.hexColor(0xf8892e).toImage(), for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(textLabel!).offset(25)
            make.height.equalTo(50)
        }
        button.addTarget(self, action: #selector(didClickButton), for: .touchUpInside)
        
    }
    
    @objc func didClickButton() {
        let path = Bundle.main.path(forResource: "available_account", ofType: "json")
        let json = try! JSON(data: NSData(contentsOfFile: path!) as Data)
        var isSuccess = false
        for (_, account):(String, JSON) in json {
            let response = login(username: account["username"].stringValue, password: account["password"].stringValue)
            print("response:\(response)")
            let result = response["result"].stringValue
            if result == "success" {
                self.result = account.stringValue
                isSuccess = true
                break
            } else if result == "online" {
                self.result = response["message"].stringValue
                isSuccess = true
                break
            }
        }
        
        if !isSuccess {
            self.result = "当前没有可用账号"
        }
        
    }
    
    func login(username: String, password: String) -> JSON {
        let url = "http://10.200.2.2:9090/zportal/login/do"
        let headers = ["Content-Type" : "application/x-www-form-urlencoded"]
        let data = [
            "username" : username,
            "pwd" : password,
            "wlanuserip" : "f09df0ee06255f08c28797b2f2383ef8",
            "nasip" : "5340d13e4208e1b891476c890b7f5f5c"
        ]
        let response =  Alamofire.request(url, method: .post, parameters: data, headers: headers)
        let json = JSON(data: response.)
        return json
        
    }
    
    func showToast(_ message:String?) {
        let alertVC = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        present(alertVC, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            alertVC.dismiss(animated: true, completion: nil)
        }
    }
    
}
