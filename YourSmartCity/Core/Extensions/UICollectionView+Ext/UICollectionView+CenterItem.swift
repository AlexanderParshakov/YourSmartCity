//
//  UICollectionView+CenterItem.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/12/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func pinFirstItemToCenter(view: UIView) {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth: CGFloat = screenSize.width * Constants.UIConfiguration.Factors.collectionCellWidth
        let cellHeight = cellWidth * 16/10
        let insetX = (CGFloat(view.bounds.width) - cellWidth) / 2.0
        let insetY: CGFloat = 20.0
        
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        self.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
    }
    
    func scrollToCenter(view: UIView) {
        let visibleItems: NSArray = (self.indexPathsForVisibleItems) as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let firstItem: IndexPath = IndexPath(item: currentItem.item, section: 0)
        let zeroItem: IndexPath = IndexPath(item: currentItem.item - 1, section: 0)
        
        self.scrollToItem(at: firstItem, at: .centeredHorizontally, animated: false)
        self.layoutIfNeeded()
        self.scrollToItem(at: zeroItem, at: .centeredHorizontally, animated: false)
    }
}
