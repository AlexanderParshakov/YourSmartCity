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
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
