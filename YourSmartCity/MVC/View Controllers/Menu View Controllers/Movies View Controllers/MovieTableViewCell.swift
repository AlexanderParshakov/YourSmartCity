//
//  MovieTableViewCell.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/13/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionWrapperView: UIView!
    @IBOutlet weak var cinemasTitleWrapperView: UIView!
    @IBOutlet weak var descriptionViewHeightConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        descriptionWrapperView.setSlightShadow(length: 4)
        descriptionWrapperView.layer.cornerRadius = 20
        
        layoutIfNeeded()
        cinemasTitleWrapperView.applyGradient()
        
        addDescriptionGestureRecognizer()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


// MARK: - Helper Methods
extension MovieTableViewCell {
    private func addDescriptionGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(switchDescriptionViewVisibility))
        
        gestureRecognizer.cancelsTouchesInView = false
        descriptionWrapperView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc
    private func switchDescriptionViewVisibility() {
        let size = CGSize(width: descriptionLabel.frame.width, height: .infinity)
        let estimatedSize = descriptionLabel.sizeThatFits(size)
        
        descriptionViewHeightConstraint.constant = descriptionViewHeightConstraint.constant == 140 ? estimatedSize.height + 100 : 140

        UIView.animate(withDuration: 0.4) {
            self.layoutIfNeeded()
        }
    }
}
