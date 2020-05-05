//
//  UIEnhancementService.swift
//  SmartCity QR-scanner
//
//  Created by Alexander Parshakov on 2/1/20.
//  Copyright © 2020 Alexander Parshakov. All rights reserved.
//

import Foundation
import UIKit

struct UIEnhancementService {
    
    private init() {}
    
    static func beautifyAccentView(view: UIView, cornerRadius: CGFloat = 10) {
        view.layer.sublayers?.forEach {
            if $0.name == "current" {
                $0.removeFromSuperlayer()
            }
        }
        view.applyGradient(colors: Constants.Colors.CGGradientSets.amin.reversed(), cornerRadius: cornerRadius)
    }
    static func beautifyNormalButton(button: UIButton) {
        button.layer.cornerRadius = 15
    }
}
