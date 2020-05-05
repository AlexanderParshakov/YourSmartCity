//
//  LayerContainerView.swift
//  SmartCity QR-scanner
//
//  Created by Alexander Parshakov on 2/8/20.
//  Copyright © 2020 Alexander Parshakov. All rights reserved.
//

import Foundation
import UIKit

class LayerContainerView: UIView {
    
    override public class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientColor: [CGColor] = [UIColor.white.cgColor, UIColor.black.cgColor]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.colors = gradientColor
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.cornerRadius = 75
    }
}
