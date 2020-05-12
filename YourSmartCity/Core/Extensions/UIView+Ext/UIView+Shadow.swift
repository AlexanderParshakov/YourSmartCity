//
//  UIView+Shadow.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/12/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setSlightShadow(shadowColor: UIColor = .darkGray, length: CGFloat = 3) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: length, height:  length)
        self.layer.shadowRadius = length * 2
        
        if traitCollection.userInterfaceStyle == .dark{
           self.layer.shadowOpacity = 0.0;
        }
        else {
            self.layer.shadowOpacity = 0.35
        }
    }
    
    func addBottomShadow(y: CGFloat) {
        self.layoutIfNeeded()
        let contactRect = CGRect(x: 0, y: self.frame.height + y, width: self.bounds.width + 30, height: 6)
        self.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        self.layer.shadowRadius = 7
        self.layer.shadowOpacity = 0.7
    }
}
