//
//  ProfileViewController.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/25/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var supportingView: UIView!
    @IBOutlet weak var sensorsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupRevealBehaviour(forButton: menuButton)
        
        self.setupUI()
    }
    
    private func setupUI() {
        self.userPicture.makeRound()
        
        self.supportingView.setSlightShadow(length: 4)
        self.supportingView.layer.cornerRadius = 15
        
        self.sensorsButton.applyGradient(cornerRadius: 10)
    }
}
