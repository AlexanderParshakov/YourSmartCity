//
//  UIView+Gradient.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/12/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func applyGradient(colors: [CGColor] = Constants.Colors.CGGradientSets.amin, cornerRadius: CGFloat = 0) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = cornerRadius == 0 ? 0 : cornerRadius
        
        gradientLayer.name = "current"

        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = true
        gradientLayer.bounds = self.bounds

        if self is UIButton {
            (self as! UIButton).contentVerticalAlignment = .center
            (self as! UIButton).setTitleColor(UIColor.white, for: .normal)
            (self as! UIButton).titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
            (self as! UIButton).titleLabel?.textColor = UIColor.white
        }
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func cleanAllSublayers() {
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }
    
    func addGradientBorder(borderWidth: CGFloat) {
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: .zero, size: self.frame.size)
        gradient.colors = Constants.Colors.CGGradientSets.amin.reversed()
        
        let shape = CAShapeLayer()
        shape.lineWidth = borderWidth
        shape.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        self.layer.addSublayer(gradient)
        self.clipsToBounds = true
        self.layoutIfNeeded()
    }
}
