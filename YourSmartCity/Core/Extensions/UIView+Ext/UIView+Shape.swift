//
//  UIView+Shape.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/25/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation

extension UIView {
    func makeRound() {
        self.layer.cornerRadius = self.frame.height / 2
    }
}
