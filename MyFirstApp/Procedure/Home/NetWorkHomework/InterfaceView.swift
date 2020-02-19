//
//  InterfaceView.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/18.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit

extension InterfaceView: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XYBaseTableCell.self)
            
            let networkNumberLabel = UILabel().then { (label) in
                label.font = UIFont.systemFont(ofSize: 14)
                label.text = "网络号："
            }
            let colonB = BaseColonLabel()
            let colonA = BaseColonLabel()
     
            
            cell.addSubview(networkNumberLabel)
            networkNumberLabel.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(15)
                make.top.bottom.equalToSuperview()
                make.width.equalTo(60)
            }
            
            cell.addSubview(networkNumCTextField)
            networkNumCTextField.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-15)
                make.width.equalTo(textFieldWidth)
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-10)
            }
            cell.addSubview(colonB)
            colonB.snp.makeConstraints { (make) in
                make.right.equalTo(networkNumCTextField.snp.left).offset(-5)
                make.width.equalTo(10)
                make.top.bottom.equalTo(networkNumCTextField)
            }
            cell.addSubview(networkNumBTextField)
            networkNumBTextField.snp.makeConstraints { (make) in
                make.right.equalTo(colonB.snp.left).offset(-5)
                make.width.equalTo(textFieldWidth)
               make.top.bottom.equalTo(networkNumCTextField)
           
            }
            cell.addSubview(colonA)
            colonA.snp.makeConstraints { (make) in
                make.right.equalTo(networkNumBTextField.snp.left).offset(-5)
                make.width.equalTo(10)
                make.top.bottom.equalToSuperview()
            }
            
            cell.addSubview(networkNumATextField)
            networkNumATextField.snp.makeConstraints { (make) in
                make.right.equalTo(colonA.snp.left).offset(-5)
                make.width.equalTo(textFieldWidth)
                make.top.bottom.equalTo(networkNumCTextField)
            }
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XYBaseTableCell.self)
            
            let hostNumberLabel = UILabel().then { (label) in
                label.font = UIFont.systemFont(ofSize: 14)
                label.text = "主机范围：(1～254)"
            }
            let colonC = BaseColonLabel().then { (label) in
                label.text = "~"
            }
            
            cell.addSubview(hostNumberLabel)
            hostNumberLabel.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(15)
                make.top.bottom.equalToSuperview()
                make.width.equalTo(150)
            }
            
            cell.addSubview(hostNumTextBField)
            hostNumTextBField.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-15)
                make.width.equalTo(textFieldWidth)
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-10)
            }
            
            cell.addSubview(colonC)
            colonC.snp.makeConstraints { (make) in
                make.right.equalTo(hostNumTextBField.snp.left).offset(-5)
                make.width.equalTo(10)
                make.top.bottom.equalToSuperview()
            }

            cell.addSubview(hostNumTextAField)
            hostNumTextAField.snp.makeConstraints { (make) in
                make.right.equalTo(colonC.snp.left).offset(-5)
                make.width.equalTo(textFieldWidth)
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-10)
            }
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XYBaseTableCell.self)
            
            let portNumberLabel = UILabel().then { (label) in
                label.font = UIFont.systemFont(ofSize: 14)
                label.text = "端口范围：(0～65535)"
            }
            cell.addSubview(portNumberLabel)
            portNumberLabel.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(15)
                make.top.bottom.equalToSuperview()
                make.width.equalTo(150)
            }
            
        
            cell.addSubview(portNumTextBField)
            portNumTextBField.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-15)
                make.width.equalTo(textFieldWidth)
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-10)
            }
            
            let colonD = BaseColonLabel().then { (label) in
                label.text = "~"
            }
            cell.addSubview(colonD)
            colonD.snp.makeConstraints { (make) in
                make.right.equalTo(portNumTextBField.snp.left).offset(-5)
                make.width.equalTo(10)
                make.top.bottom.equalToSuperview()
            }
            
            cell.addSubview(portNumTextAField)
            portNumTextAField.snp.makeConstraints { (make) in
                make.right.equalTo(colonD.snp.left).offset(-5)
                make.width.equalTo(textFieldWidth)
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-10)
            }
           
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XYBaseTableCell.self)
            
            let scanTimesLabel = UILabel().then { (label) in
                label.font = UIFont.systemFont(ofSize: 14)
                label.text = "扫描次数："
            }
           
            cell.addSubview(scanTimesLabel)
            scanTimesLabel.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(15)
                make.top.bottom.equalToSuperview()
                make.width.equalTo(70)
            }
            
            cell.addSubview(scanTimesStepper)
            scanTimesStepper.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-15)
                make.top.equalToSuperview().offset(7)
            }
            
            cell.addSubview(scanTimesTextField)
            scanTimesTextField.snp.makeConstraints { (make) in
                make.left.equalTo(scanTimesLabel.snp.right).offset(5)
                make.width.equalTo(25)
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-10)
            }
            let timeLabel = UILabel().then { (label) in
                label.font = UIFont.systemFont(ofSize: 14)
                label.text = "次"
            }
            cell.addSubview(timeLabel)
            timeLabel.snp.makeConstraints { (make) in
                make.left.equalTo(scanTimesTextField.snp.right).offset(5)
                make.width.equalTo(15)
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-10)
                
            }
            
            
            return cell
            
        case 4 :
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XYBaseTableCell.self)
            
            let timeoutLabel = UILabel().then { (label) in
                label.font = UIFont.systemFont(ofSize: 14)
                label.text = "超时："
            }
            cell.addSubview(timeoutLabel)
            timeoutLabel.snp.makeConstraints { (make) in
                make.top.bottom.equalToSuperview()
                make.left.equalToSuperview().offset(15)
                make.width.equalTo(70)
            }
            
            cell.addSubview(timeoutStepper)
            timeoutStepper.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-15)
                make.top.equalToSuperview().offset(7)
            }
            
            cell.addSubview(timeoutTextField)
            timeoutTextField.snp.makeConstraints { (make) in
                make.left.equalTo(timeoutLabel.snp.right).offset(5)
                make.width.equalTo(25)
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-10)
            }
            let timeLabel = UILabel().then { (label) in
                label.font = UIFont.systemFont(ofSize: 14)
                label.text = "秒"
            }
            cell.addSubview(timeLabel)
            timeLabel.snp.makeConstraints { (make) in
                make.left.equalTo(timeoutTextField.snp.right).offset(5)
                make.width.equalTo(15)
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-10)
                
            }
            
            return cell
        case 5 :
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XYBaseTableCell.self)
            cell.addSubview(startPauseButton)
            startPauseButton.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(100)
                make.top.equalToSuperview().offset(8)
                make.bottom.equalToSuperview().offset(-8)
                make.width.equalTo(50)
            }
            
            cell.addSubview(stopButton)
            stopButton.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-100)
                make.top.bottom.width.equalTo(startPauseButton)
            }
            
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XYBaseTableCell.self)
            
            cell.addSubview(percentLabel)
            percentLabel.snp.makeConstraints { (make) in
             
                make.right.equalToSuperview().offset(-15)
                make.width.equalTo(30)
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-10)
            }
            
            cell.addSubview(progress)
            progress.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(15)
                make.bottom.equalToSuperview().offset(-15)
                make.left.equalToSuperview().offset(15)
                make.right.equalTo(percentLabel.snp.left).offset(-15)
            }
                   
            return cell
            
        default:
             return tableView.dequeueReusableCell(for: indexPath, cellType: XYBaseTableCell.self)
                      
        }
    }
    
    
    
}

class InterfaceView: UITableView {
    
    let  networkNumATextField = BaseTextField().then {
        $0.text = "192"
    }
    let networkNumBTextField = BaseTextField().then {
        $0.text = "168"
    }
    let networkNumCTextField = BaseTextField().then {
        $0.text = "1"
    }
    
    let hostNumTextAField = BaseTextField().then { (textField) in
        textField.text = "1"
    }
    let hostNumTextBField = BaseTextField().then {
        $0.text = "254"
    }
    
    let portNumTextAField = BaseTextField().then {
        $0.text = "0"
    }
    let portNumTextBField = BaseTextField().then {
        $0.text = "1024"
    }
    
    let progress = UIProgressView(progressViewStyle: .default).then {
        $0.progressTintColor = .systemBlue
        $0.trackTintColor = .lightGray
        $0.progress = 0
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        
    }
    
    let percentLabel = UILabel().then { (label) in
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0 %"
    }
    
    let scanTimesTextField = BaseTextField().then { (textField) in
        textField.text = "1"
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .clear
     }
    
    let timeoutTextField = BaseTextField().then { (textField) in
        textField.text = "2.0"
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .clear
        
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        separatorStyle = .none
        delegate = self
        dataSource = self
        register(cellType: XYBaseTableCell.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let textFieldWidth = 50
    
    var startPauseButtonBlock: ((_ state: Int) -> Void)?
    var startPauseButtonState = 0
    let startPauseButton = UIButton().then { (button) in
        button.setTitle("开始", for: .normal)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(onStartPauseButtonClicked), for: .touchUpInside)
    }
    @objc func onStartPauseButtonClicked() {
        startPauseButtonBlock?(startPauseButtonState)
        if startPauseButtonState == 0 || startPauseButtonState == 2 {
            startPauseButton.setTitle("暂停", for: .normal)
            startPauseButtonState = 1
        } else if startPauseButtonState == 1{
            startPauseButton.setTitle("继续", for: .normal)
            startPauseButtonState = 2
        }
  
    }
    var stopButtonBlock: XYBlock?
    let stopButton = UIButton().then { (button) in
        button.setTitle("停止", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(onStopButtonClicked), for: .touchUpInside)
    }
    
    @objc func onStopButtonClicked() {
        stopButtonBlock?()
        startPauseButton.setTitle("开始", for: .normal)
        startPauseButtonState = 0
    }

    let timeoutStepper = UIStepper().then {(stepper) in
        stepper.value = 2
        stepper.minimumValue = 0.5
        stepper.maximumValue = 5
        stepper.stepValue = 0.5
        stepper.autorepeat = true
        stepper.isContinuous = true
        stepper.addTarget(self, action: #selector(onTimeoutStepperChange), for: .valueChanged)
    }
    
    @objc func onTimeoutStepperChange() {
        timeoutTextField.text = "\(timeoutStepper.value)"
    
    }
    

    let scanTimesStepper = UIStepper().then {  (stepper) in
        stepper.value = 1
        stepper.minimumValue = 1
        stepper.maximumValue = 5
        stepper.stepValue = 1
        stepper.autorepeat = true
        stepper.isContinuous = true
        stepper.addTarget(self, action: #selector(onScanTimesStepperChange), for: .valueChanged)
    }
    
    @objc func onScanTimesStepperChange() {
      scanTimesTextField.text = "\(Int(scanTimesStepper.value))"
  }
    
   
    
   
}

class BaseTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        font = .systemFont(ofSize: 15)
        layer.cornerRadius = 13
        textAlignment = .center
        keyboardType = .numberPad
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BaseColonLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = .systemFont(ofSize: 18)
        text = "."
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

