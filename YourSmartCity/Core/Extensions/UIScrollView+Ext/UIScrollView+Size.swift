//
//  UIScrollView+Size.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 5/1/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation

extension UIScrollView {
   func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
    }
}
