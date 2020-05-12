//
//  FoodCollectionViewCell.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/11/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleWrapperView: UIView!
    
    // MARK: - Variables
    var restaurant: Restaurant = Restaurant()
    
    // MARK: - Constraints
    @IBOutlet weak var thumbnailWidthConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbnailImage.clipsToBounds = true
        thumbnailImage.layer.cornerRadius = 10
        
        titleWrapperView.layer.cornerRadius = titleWrapperView.frame.height / 2
        let screenSize = UIScreen.main.bounds.size
        thumbnailWidthConstraint.constant = screenSize.width * Constants.UIConfiguration.Factors.collectionCellWidth
        
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.borderWidth = 4.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true;

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 8, height: 8)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.6
        self.layer.masksToBounds = false;
        
        layoutIfNeeded()
    }
    
    
    func set(withRestaurant restaurant: Restaurant) {
        self.restaurant = restaurant
        thumbnailImage.image = UIImage(data: restaurant.pictureData ?? Data())
        titleLabel.text = restaurant.name
    }
    
}
