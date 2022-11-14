//
//  WActivityView.swift
//  InWallet
//
//  Created by hanjinsik on 2022/11/14.
//

/**
 커스텀 로딩 뷰
 */
import UIKit

let k_animation_duration = 1.0
let k_min_alpha = 0.3
let k_max_alpha = 1.0

class WActivityView: NSObject {
    
    var view: UIView!
    var imgView: UIImageView!
    
    
    public static let shared = WActivityView()
    
    override init() {
        self.view = UIView(frame: UIScreen.main.bounds)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        self.imgView = UIImageView(frame: CGRect(x: self.view.center.x - 45, y: self.view.center.y - 45, width: 90, height: 90))
        
        var arr = [UIImage]()
        
        for i in 0...30 {
            let str = String(format: "loading%02d", i)
            let img = UIImage(named: str)
            arr.append(img!)
        }
        
        self.imgView.animationImages = arr
        self.imgView.animationDuration = k_animation_duration
        self.imgView.animationRepeatCount = 0
        self.imgView.clipsToBounds = true
        self.view.addSubview(self.imgView)
        self.imgView.alpha = k_min_alpha
    }
    
    
    
    func start() {
        let isAnimate = self.isAnimate()
        
        if !isAnimate {
            let window = UIApplication.shared.delegate?.window
            
            DispatchQueue.main.async {
                window!!.addSubview(self.view)
                self.imgView.alpha = k_max_alpha
                self.imgView.startAnimating()
            }
        }
    }
    
    
    func stop() {
        DispatchQueue.main.async {
            self.imgView.stopAnimating()
            self.view.removeFromSuperview()
        }
    }
    
    
    internal func isAnimate() -> Bool {
        let window = UIApplication.shared.delegate?.window
        
        if self.view.superview == window {
            return true
        }
        
        return false
    }
}
