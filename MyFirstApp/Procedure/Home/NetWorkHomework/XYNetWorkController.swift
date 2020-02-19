//
//  XYNetWorkController.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/18.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit
import SwiftSocket
import SVProgressHUD
class XYNetWorkController: XYBaseViewController {
    
    let semaphore = DispatchSemaphore(value: 1)
    
    let queue = DispatchQueue(label: "me.xiaoyuu", qos: .utility, attributes: .concurrent)
    var count = 0
    var finishCount = 0 {
        didSet {
            let percent = Float(finishCount) / Float(count)
            interfaceView.progress.progress = percent
            interfaceView.percentLabel.text = "\(percent * 100) %"
            interfaceView.reloadData()
        }
    }
    private lazy var result = [String:[Int]]()
    
    private lazy var interfaceView = InterfaceView()
    
    private lazy var interfaceCell = XYBaseTableCell().then { cell in
        cell.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 320)
        cell.addSubview(interfaceView)
        interfaceView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    private lazy var tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: .plain).then {
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = true
        $0.separatorStyle = .none
        
        $0.delegate = self
        $0.dataSource = self
        $0.register(cellType: XYBaseTableCell.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "端口扫描"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
             make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        
        interfaceView.startPauseButtonBlock = {[unowned self] (state) in
            self.start(state)
        }
        
        interfaceView.stopButtonBlock = { [unowned self] in
            self.stop()
        }
        
    }
    
    func stop() {
        
    }
    
    func start(_ state: Int) {
        print("state:\(state)")
        if state == 1{
            // MARK: 暂停
            return
        }
        if state == 2 {
            // MARK: 继续
            return
        }
        
        guard  let networkAStr = interfaceView.networkNumATextField.text, let networkBStr = interfaceView.networkNumBTextField.text,let networkCStr = interfaceView.networkNumCTextField.text else {
            
            SVProgressHUD.showError(withStatus: "请输入网络号!")
            SVProgressHUD.dismiss(withDelay: 2)
            return
        }
        guard let networkA = Int(networkAStr), let networkB = Int(networkBStr),let networkC = Int(networkCStr) else {
            SVProgressHUD.showError(withStatus: "输入含有非数字!")
            SVProgressHUD.dismiss(withDelay: 2)
            return
        }
        guard networkA >= 192 && networkA <= 223, networkB >= 0 && networkB <= 255, networkC >= 0 && networkC <= 255 else {
            SVProgressHUD.showError(withStatus: "网络号有误！\n范围：192.0.0～223.255.255")
            SVProgressHUD.dismiss(withDelay: 2)
            return
        }
        var startHost = 1
        var endHost = 254
       
        if let hostAStr = interfaceView.hostNumTextAField.text, let hostA = Int(hostAStr),hostA >= 1 && hostA <= 254  {
            startHost = hostA
        }
        if let hostBStr = interfaceView.hostNumTextBField.text, let hostB = Int(hostBStr),hostB >= 1 && hostB <= 254 {
            endHost = hostB
        }
        if startHost > endHost {
            swap(&startHost, &endHost)
        }
        
        var startPort = 0
        var endPort = 1024
        if let portAStr = interfaceView.portNumTextAField.text, let portA = Int(portAStr), portA >= 0 && portA <= 65535 {
            startPort = portA
        }
        if let portBStr = interfaceView.portNumTextBField.text, let portB = Int(portBStr), portB >= 0 && portB <= 65535 {
            endPort = portB
        }
        if startPort > endPort {
            swap(&startPort, &endPort)
        }
        
        let host = "\(networkA).\(networkB).\(networkC)."
        let scanTime = Int(interfaceView.scanTimesTextField.text!)!
        let timeout = Double(interfaceView.timeoutTextField.text!)!
        startThread(hostA: host, startHost: startHost, endHost: endHost, startPort: startPort, endPort: endPort, scanTime: scanTime, timeout: timeout)
        
        
    }
    func startThread(hostA: String,startHost: Int,endHost: Int, startPort: Int, endPort: Int, scanTime: Int, timeout: Double){
        print("开始线程")
        count = (endHost - startHost + 1) * (endPort - startPort) * scanTime
        let num = (endHost - startHost) / 5
        for i in 0..<5 {
            queue.async { [weak self] in
                for hostB  in (startHost + i * num)...(startHost + (i+1) * num) {
                    for port in startPort...endPort {
                        for _ in 1...scanTime {
                            let result = self?.getConnect(host: "\(hostA)\(hostB)", port: port, timeout: Int(timeout))
                            
                            if self?.semaphore.wait(wallTimeout: .distantFuture) == .success {
                                if let aresult = result, aresult {
                                    self?.result["\(hostA)\(hostB)"]?.append(port)
                                    print("\(hostA)\(hostB):\(port)")
                                }
                                self?.count += 1
                                self?.semaphore.signal()
                            }
                         
                            
                        }
                        
                    }
                }
            }
        }
       
        
    }
    
    func getConnect(host: String, port: Int, timeout: Int) -> Bool {
        let client = TCPClient(address: host, port: Int32(port))
        return client.connect(timeout: timeout).isSuccess
    }
    
    
    
}

extension XYNetWorkController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 320
        default:
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return result.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            
            return interfaceCell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XYBaseTableCell.self)
            let key = result.keys[result.index(result.startIndex, offsetBy: indexPath.row)]
        
            var text = "\(key):"
            if let values = result[key]{
                for v in values {
                    text.append(contentsOf: " \(v)")
                }
            }
            cell.textLabel?.text = text
            return cell
        }
    }
    
    
}
