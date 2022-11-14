//
//  WUtils.swift
//  InWalletSDK-iOS_Example
//
//  Created by hanjinsik on 2022/05/24.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

typealias AlertAction = (Int?) -> Void

class WUtils: NSObject {

    class func showAlert(message: String? = "오류가 발생했습니다.\n잠시 후 다시 시도해주세요.", controller: UIViewController, onComplection: AlertAction?) -> Void {
        
        let alert = UIAlertController.init(title: "", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction.init(title: "확인", style: .default) { (action) in
            if onComplection != nil {
                onComplection!(0)
            }
            
        }
        alert.addAction(action)
        
        DispatchQueue.main.async {
            controller.present(alert, animated: true, completion: nil)
        }
    }
    
    
    class func showAlert(title: String? = "", message: String? = "오류가 발생했습니다.\n잠시 후 다시 시도해주세요.", buttons: [String], controller: UIViewController, onComplection: AlertAction?) -> Void {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        if buttons.count > 1 {
            let action = UIAlertAction.init(title: buttons[0], style: .default) { (action) in
                if onComplection != nil {
                    onComplection!(0)
                }
            }
            
            let action1 = UIAlertAction.init(title: buttons[1], style: .default) { (action) in
                if onComplection != nil {
                    onComplection!(1)
                }
            }
            
            alert.addAction(action)
            alert.addAction(action1)
        }
        else {
            let action = UIAlertAction.init(title: buttons[0], style: .default) { (action) in
                if onComplection != nil {
                    onComplection!(0)
                }
            }
            
            alert.addAction(action)
        }
        
        DispatchQueue.main.async {
            controller.present(alert, animated: true, completion: nil)
        }
    }
}
