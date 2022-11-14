//
//  AuthViewController.swift
//  InWalletSDK_Example
//
//  Created by hanjinsik on 2022/05/23.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import InWalletSDK

class AuthViewController: ViewController {
    
    var requestId: String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(enterForeground), name: NSNotification.Name("applicationWillEnterForeground"), object: nil)
    }
    
    
    @IBAction func okButtonAction() {
        WActivityView.shared.start()
        
        let metaData = MetaData(name: "InWalletSample", description: "description")
        
        InWalletSDK.proposal(metaData: metaData, sendData: nil) { requestID, statusCode in
            WActivityView.shared.stop()
            
            if statusCode == 200 {
                print("OK")
                
                self.requestId = requestID!
            }
        }
    }
    
    
    /**
     foreground 상태일 때 appdelegate에서 노티를 받아서 결과 요청
     */
    @objc func enterForeground() {
        
        guard let requestId = self.requestId, !requestId.isEmpty else {
            return
        }
        
        WActivityView.shared.start()
        
        InWalletSDK.getResult(requestId: requestId) { dic, statusCode in
            WActivityView.shared.stop()
            
            guard let dic = dic, let status = dic["status"] as? String else {
                return
            }
            
            if status == "completed" {
                guard let result = dic["result"] as? Dictionary<String, Any> else {
                    return
                }
                
                if let address = result["address"] as? String {
                    print(address)
                    WUtils.showAlert(title: "실행 완료", message: address, buttons: ["OK"], controller: self, onComplection: nil)
                }
            }
            else if status == "canceled" {
                WUtils.showAlert(title: "실행 취소", message: status, buttons: ["OK"], controller: self, onComplection: nil)
            }
        }
    }
    
    
    @IBAction func resultButtonAction() {
        
    }
}
