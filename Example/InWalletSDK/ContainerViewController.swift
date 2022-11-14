//
//  ContainerViewController.swift
//  InWalletSDK_Example
//
//  Created by hanjinsik on 2022/11/14.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class ContainerViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let tabItems = self.tabBar.items {
            tabItems[0].title = "AUTH"
            tabItems[1].title = "SendLIPC"
            tabItems[2].title = "SendToken"
            tabItems[3].title = "SendNFT"
            tabItems[4].title = "EXECUTE"
        }
    }

}
