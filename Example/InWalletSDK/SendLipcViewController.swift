//
//  SendLipcViewController.swift
//  InWalletSDK-iOS_Example
//
//  Created by hanjinsik on 2022/11/14.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import InWalletSDK

class SendLipcViewController: ViewController {
    
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    
    var requestId: String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(enterForeground), name: NSNotification.Name("applicationWillEnterForeground"), object: nil)
        
//        self.fromTextField.text = "0x5225320c897867dACF38b6B7c28c147bB6988151"
//        self.toTextField.text = "0xbd39562DcdF9344E3F516716C27Ec5eb022e638F"
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
        
        
        WActivityView.shared.start()
        
        let metaData = MetaData(name: "dappName", description: "description", url: "url", icon: "iconUrl", successCallback: "", failureCallback: "")
        let sendLipc = SendLipc(from: from, to: to, value: value)
        
        InWalletSDK.proposal(metaData: metaData, sendData: sendLipc) { requestID, statusCode in
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
