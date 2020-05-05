//
//  UITableView+IndexOfCell.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 5/2/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation

extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else { return false }

        return lastIndexPath == indexPath
    }
}
