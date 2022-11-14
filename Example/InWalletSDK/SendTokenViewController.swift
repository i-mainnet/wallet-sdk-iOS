//
//  SendTokenViewController.swift
//  InWalletSDK_Example
//
//  Created by hanjinsik on 2022/11/14.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import InWalletSDK

class SendTokenViewController: ViewController {
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var contractTextField: UITextField!
    
    var requestId: String? = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(enterForeground), name: NSNotification.Name("applicationWillEnterForeground"), object: nil)
    }
    

    @IBAction func okButtonAction() {
        guard let from = self.fromTextField.text, !from.isEmpty else {
            return
        }
        
        guard let to = self.toTextField.text, !to.isEmpty else {
            return
        }
        
        guard let value = self.valueTextField.text, !value.isEmpty else {
            return
        }
        
        guard let contract = self.contractTextField.text, !contract.isEmpty else {
            return
        }
        
        WActivityView.shared.start()
        
        let metaData = MetaData(name: "dappName", description: "description", url: "url", icon: "iconUrl", successCallback: "", failureCallback: "")
        let sendToken = SendToken.init(from: from, to: to, value: value, contract: contract)
        
        InWalletSDK.proposal(metaData: metaData, sendData: sendToken) { requestID, statusCode in
            WActivityView.shared.stop()
            
            guard let requestId = requestID, !requestId.isEmpty else {
                return
            }
            
            self.requestId = requestID
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
                
                if let txId = result["transactionHash"] as? String {
                    print(txId)
                    WUtils.showAlert(title: "실행 완료", message: txId, buttons: ["OK"], controller: self, onComplection: nil)
                }
            }
            else if status == "canceled" {
                WUtils.showAlert(title: "실행 취소", message: status, buttons: ["OK"], controller: self, onComplection: nil)
            }
        }
    }

}
