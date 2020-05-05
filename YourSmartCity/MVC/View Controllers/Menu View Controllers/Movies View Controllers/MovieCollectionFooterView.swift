//
//  MovieCollectionFooterView.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/13/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import UIKit

class MovieCollectionFooterView: UICollectionReusableView {
     
    @IBOutlet weak var backgroundViewCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var showAllLabel: UILabel!
    
    
    override func awakeFromNib() {
//        let screenWidth = UIScreen.main.bounds.width
//        let cellWidth = screenWidth * Constants.UIConfiguration.Factors.collectionCellWidth + 1
//        backgroundViewCenterXConstraint.constant = - ((screenWidth - cellWidth) / 2)
        
        
        backgroundView.layoutIfNeeded()
        addDescriptionGestureRecognizer()
    }
    
    private func addDescriptionGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showAllMovies))
        
        gestureRecognizer.cancelsTouchesInView = false
        backgroundView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc
    private func showAllMovies() {
        
    }
}
