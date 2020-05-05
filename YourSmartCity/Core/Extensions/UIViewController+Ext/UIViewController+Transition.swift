//
//  UIViewController+Transition.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/26/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation

extension UIViewController {
    func addSmoothTransitionBehaviour() {
        let popGestureRecognizer = self.navigationController!.interactivePopGestureRecognizer!
        if let targets = popGestureRecognizer.value(forKey: "targets") as? NSMutableArray {
          let gestureRecognizer = UIPanGestureRecognizer()
          gestureRecognizer.setValue(targets, forKey: "targets")
          self.view.addGestureRecognizer(gestureRecognizer)
        }
    }
}
