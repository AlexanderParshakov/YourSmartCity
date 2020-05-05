//
//  AnimationView+Lifecycle.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 5/3/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation
import Lottie

extension AnimationView {
    
    func startVioletLoadingAnimation() {
        self.animation = Animation.named("GradientLoader")
        self.loopMode = .loop
        self.play()
        self.isHidden = false
    }
    
}
