//
//  UIImageView+Paint.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/15/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func changeColor(to color: UIColor) {
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}
