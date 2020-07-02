//
//  OrganizationListViewController.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/19/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import UIKit
import Lottie

class BuildingViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var detailsWrapperView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var organizationsTltleWrapperView: UIView!
    @IBOutlet weak var organizationTableView: UITableView!
    @IBOutlet weak var organizationLoader: AnimationView!
    
    
    // MARK: - Variables
    var buildingId: Int = -1
    private var building: Building = Building()
    private var organizationList: [Organization] = []
    
    private var allRowsAnimated = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        detailsWrapperView.layer.cornerRadius = 15
        detailsWrapperView.setSlightShadow(shadowColor: .systemGray)
        organizationsTltleWrapperView.applyGradient()
        
        organizationTableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: organizationTableView.frame.width, height: 205)
        
        organizationLoader.startVioletLoadingAnimation()
        
        NetworkService.Scanning.getBuilding(byId: self.buildingId) { [weak self] (result) in
            switch result {
            case .success(let building):
                self?.building = building
                self?.addressLabel.text = building.fullAddress
                
                self?.organizationList.append(contentsOf: building.cinemas ?? [])
                self?.organizationList.append(contentsOf: building.museums ?? [])
                self?.organizationList.append(contentsOf: building.restaurants ?? [])
                
                self?.organizationLoader.isHidden = true
                self?.organizationTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCinemaInfo" {
            let cinemaVC = segue.destination as! CinemaViewController
        }
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension BuildingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !allRowsAnimated {
            let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 0.45, delayFactor: 0.25)
            let animator = Animator(animation: animation)
            animator.animate(cell: cell, at: indexPath, in: tableView)
            if tableView.isLastVisibleCell(at: indexPath) {
                allRowsAnimated = true
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        organizationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = organizationTableView.dequeueReusableCell(withIdentifier: "OrganizationTableViewCell") as! OrganizationTableViewCell
        let currentOrganization = organizationList[indexPath.row]
        cell.set(withOrganization: currentOrganization)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCinemaInfo", sender: self)
    }
}

