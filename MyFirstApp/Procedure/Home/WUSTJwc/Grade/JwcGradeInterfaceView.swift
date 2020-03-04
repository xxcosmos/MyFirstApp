//
//  JwcGradeInterfaceView.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/22.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit
import SVProgressHUD

class JwcGradeInterfaceView: UIView {
    
    private var studentIdInput = UITextField().then { textField in
        textField.keyboardType = .numberPad
        textField.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        textField.font = .systemFont(ofSize: 20)
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.placeholder = "请输入学号"
        textField.placeholderRect(forBounds: CGRect(x: 15, y: 5, width: 50, height: 30))
        textField.clearButtonMode = .always
        
    }
    
    private var button = UIButton().then { (button) in
        button.setTitle("查询", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
    
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
    }
    
    private var studentInfoLabel = UILabel().then { (label) in
        label.font = .systemFont(ofSize: 15)
        label.backgroundColor = .white
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(studentIdInput)
        studentIdInput.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(50)
            make.height.equalTo(35)
            make.width.equalTo(200)
        }
        
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(studentIdInput)
            make.right.equalToSuperview().offset(-50)
            make.width.equalTo(60)
        }
        
        addSubview(studentInfoLabel)
        studentInfoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(studentIdInput.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        
    }
    
    var studentInfo: [String]? {
        didSet {
            guard let info = studentInfo else {return}
            self.studentInfoLabel.text = "姓名：\(info[0])  学号：\(info[1])  GPA:\(info[2])"
        }
    }
    
    var buttonActionBlock: ((_ studentId: String) -> Void)?
    
    @objc func buttonAction(){
        let studentId = studentIdInput.text!
        guard  studentId != "" else {
            SVProgressHUD.showError(withStatus: "请输入要查询的学号！")
            SVProgressHUD.dismiss(withDelay: 2)
            return
        }
        guard studentIdValidate(studentId) else {
            SVProgressHUD.showError(withStatus: "学号输入有误！")
            SVProgressHUD.dismiss(withDelay: 2)
            return
        }
        buttonActionBlock?(studentId)
    }
    
    func studentIdValidate(_ studentId: String) -> Bool {
        guard studentId.count == 12 else {
            return false
        }
        for c in studentId {
            if !c.isNumber {
                return false
            }
        }
        return true
    }
    
}

