//
//  OrganizationTableViewCell.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 5/3/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import UIKit

class OrganizationTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameWrapperView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var selectionShadowView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        thumbnail.image = UIImage(named: "Cabinet")
        thumbnail.layer.cornerRadius = 10
        
        nameWrapperView.layer.cornerRadius = 10
        selectionView.roundCorners(corners: [.topRight, .bottomRight], radius: 7)
        selectionShadowView.setSlightShadow(length: 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func set(withOrganization org: Organization) {
        nameLabel.text = org.name
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
