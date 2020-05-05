//
//  OrganizationListViewController.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/19/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import UIKit
import Lottie

class OrganizationListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var detailsWrapperView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var organizationsTltleWrapperView: UIView!
    @IBOutlet weak var organizationTableView: UITableView!
    @IBOutlet weak var organizationLoader: AnimationView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        detailsWrapperView.layer.cornerRadius = 15
        detailsWrapperView.setSlightShadow(shadowColor: .systemGray)
        organizationsTltleWrapperView.applyGradient()
        
        organizationLoader.startVioletLoadingAnimation()
    }
    
}
