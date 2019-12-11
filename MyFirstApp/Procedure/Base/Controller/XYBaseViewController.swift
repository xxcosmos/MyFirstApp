//
//  XYBaseViewController.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2019/12/9.
//  Copyright © 2019 xiaoyuu. All rights reserved.
//

import UIKit
import RxSwift

class XYBaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
//        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
    
    }
    
    func showToast(_ message:String?) {
         let alertVC = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
         present(alertVC, animated: true, completion: nil)
         DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
             alertVC.dismiss(animated: true, completion: nil)
         }
     }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
