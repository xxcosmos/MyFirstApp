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
import Moya
import RxSwift
import RxCocoa
import RxBlocking

enum WustWirelessResult {
    case success
    case internalError
    case noResult
}

class XYWirelessViewController: XYBaseViewController {
    
    private var resultLabel = UILabel()
    private var wustWirelessResult = WustWirelessResult.noResult
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "免费校园网"
        
        resultLabel.font = UIFont.boldSystemFont(ofSize: 15)
        view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints({ (make) in
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
            make.top.equalTo(resultLabel).offset(25)
            make.height.equalTo(50)
        }
        
        button.rx.tap.bind { [weak self] in
            self?.didClickButton()
        }.disposed(by: disposeBag)
        
    }
    
    func didClickButton() {
        let path = Bundle.main.path(forResource: "available_account", ofType: "json")
        let accounts = try! JSON(data: NSData(contentsOfFile: path!) as Data)
        let myQueue = DispatchQueue(label: "myqueue")
        myQueue.async {
            for (_, account):(String, JSON) in accounts {
                self.login(username: account["username"].stringValue, password: account["password"].stringValue)
                sleep(1)
                if self.wustWirelessResult == .internalError  || self.wustWirelessResult == .success {
                    return
                }
            }
        }
        
        
        
    }
    

    func login(username: String, password: String) {
        print(username,password)
        let provider = MoyaProvider<XYAPI>()
        
        provider.request(.loginToWustWireless(username: username, password: password)) { (result) in
            switch result {
            case let .success(moyaResponse):
                let response = try! JSON(data: moyaResponse.data)
                print(response)
                let result = response["result"].stringValue
                if result == "success" {
                    self.resultLabel.text = "username:\(username),password:\(password)"
                    self.wustWirelessResult = .success
                } else if result == "online" {
                    self.wustWirelessResult = .success
                } else {
                    let message = response["message"].stringValue
                    if message.contains("内部") {
                        self.resultLabel.text = message
                        self.wustWirelessResult = .internalError
                    }
                }
                
            case let .failure(error):
                print(error)
            }
        }
     
        
    }
    
 
    
}
