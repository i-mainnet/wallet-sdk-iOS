//
//  ViewController.swift
//  InWalletSDK
//
//  Created by jinsikhan on 11/14/2022.
//  Copyright (c) 2022 jinsikhan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(didTapView(_:)))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(gesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        if sender.view is UITextField {
            return
        }
        
        self.view.endEditing(true)
    }

}

