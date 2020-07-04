//
//  MenuTableViewController.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/14/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    // MARK: - Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    
    @IBOutlet weak var homeImageView: UIImageView!
    @IBOutlet weak var homeLabel: UILabel!
    
    @IBOutlet weak var entertainmentImageView: UIImageView!
    @IBOutlet weak var entertainmentLabel: UILabel!
    
    @IBOutlet weak var foodsImageView: UIImageView!
    @IBOutlet weak var foodsLabel: UILabel!
    
    
    // MARK: - Constraints
    @IBOutlet weak var profileImageWidthConstraint: NSLayoutConstraint!
    
    
    // MARK: - Variables
    private var imageViews: [UIImageView] {
        return [homeImageView, entertainmentImageView, foodsImageView]
    }
    private var labels: [UILabel] {
        return [homeLabel, entertainmentLabel, foodsLabel]
    }
    
    private let accentColor = UIColor.systemIndigo
    
    private let zeroSectionFooterHeight: CGFloat = 15
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.selectHomePage()
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        profileImageView.makeRound()
    }
    
    private func selectHomePage() {
        let homeIndexPath = IndexPath(item: 0, section: 1)
        self.tableView.selectRow(at: homeIndexPath, animated: false, scrollPosition: UITableView.ScrollPosition.middle)
        self.highlightRow(withIndex: 0)
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { // Profile
            return 1
        } else { // Menu Options
            return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                if (UIApplication.topViewController() as? ProfileViewController) != nil {
                    self.revealViewController()?.revealToggle(self)
                } else {
                    let homeViewController = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileNavigationController") as! UINavigationController
                    self.revealViewController()?.pushFrontViewController(homeViewController, animated: true)
                }
            }
            self.highlightProfile()
        } else { // Menu Options
            // Home page
            if indexPath.row == 0 {
                if (UIApplication.topViewController() as? HomeViewController) != nil {
                    self.revealViewController()?.revealToggle(self)
                } else {
                    let homeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationController") as! UINavigationController
                    self.revealViewController()?.pushFrontViewController(homeViewController, animated: true)
                }
            }
            // Entertainment
            else if indexPath.row == 1 {
                if (UIApplication.topViewController() as? EntertainmentViewController) != nil {
                    self.revealViewController()?.revealToggle(self)
                } else {
                    let entViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EntertainmentNavigationController") as! UINavigationController
                    self.revealViewController()?.pushFrontViewController(entViewController, animated: true)
                }
            }
            // Foods
            else if indexPath.row == 2 {
                if (UIApplication.topViewController() as? RestaurantsViewController) != nil {
                    self.revealViewController()?.revealToggle(self)
                } else {
                    let entViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FoodsNavigationController") as! UINavigationController
                    self.revealViewController()?.pushFrontViewController(entViewController, animated: true)
                }
            }
            self.highlightRow(withIndex: indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return zeroSectionFooterHeight
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = .systemBackground
    }
    
}


// MARK: - Helper Methods
extension MenuTableViewController {
    private func highlightRow(withIndex rowIndex: Int) {
        // painting image
        for (index, imageView) in imageViews.enumerated() {
            if index == rowIndex {
                imageView.changeColor(to: self.accentColor)
            } else {
                imageView.changeColor(to: .label)
            }
        }
        // painting label
        for (index, label) in labels.enumerated() {
            if index == rowIndex {
                label.textColor = self.accentColor
                label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            } else {
                label.textColor = .label
                label.font = UIFont.systemFont(ofSize: 17)
            }
        }
        
        profileImageView.cleanAllSublayers()
        
        UIView.animate(withDuration: 0.1) {
            self.profileLabel.textColor = .label
            self.profileLabel.font = UIFont.systemFont(ofSize: 17)
        }
    }
    
    private func highlightProfile() {
        profileImageView.addGradientBorder(borderWidth: 4)
        
        UIView.animate(withDuration: 0.1) {
            self.profileLabel.textColor = self.accentColor
            self.profileLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        }
        
        // dehighlight images
        for imageView in imageViews {
            imageView.changeColor(to: .label)
        }
        // dehighlight labels
        for label in labels {
            label.textColor = .label
            label.font = UIFont.systemFont(ofSize: 17)
        }
    }
}
