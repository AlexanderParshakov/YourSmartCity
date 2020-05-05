//
//  FoodsViewController.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/15/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import UIKit

class FoodsViewController: UIViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupRevealBehaviour(forButton: menuButton)
    }
    
}
