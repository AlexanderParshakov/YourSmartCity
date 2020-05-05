//
//  UIView+SWReveal.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/11/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func setupRevealBehaviour(forButton button: UIBarButtonItem, usePanGesture: Bool = true) {
        button.target = self.revealViewController()
        button.action = #selector(SWRevealViewController.revealToggle(_:))
        guard let revealViewController = self.revealViewController() else { return }
        self.revealViewController()?.rearViewRevealWidth = 280
        
        if usePanGesture { self.view.addGestureRecognizer(revealViewController.panGestureRecognizer()) }
    }
}

extension UIApplication {
    class func topViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        var topVC = keyWindow?.rootViewController
        while true {
            if let presented = topVC?.presentedViewController {
                topVC = presented
            } else if let nav = topVC as? UINavigationController {
                topVC = nav.visibleViewController
            } else if let tab = topVC as? UITabBarController {
                topVC = tab.selectedViewController
            }else if let swRVC = topVC as? SWRevealViewController {
                topVC = swRVC.frontViewController
            } else {
                break
            }
        }
        return topVC
    }
}
