//
//  SensorsViewController.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/26/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import UIKit

class SensorsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var sensorTableView: UITableView!
    @IBOutlet weak var addSensorBarButton: UIBarButtonItem!
    
    
    // MARK: - Variables
    var sensorList: [Sensor] = []
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        sensorList = Repository.getSensors()
        
        self.addSmoothTransitionBehaviour()
    }
    
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension SensorsViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sensorList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SensorTableViewCell", for: indexPath) as! SensorTableViewCell
        cell.set(with: sensorList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            
            let editImage = UIImage(named: "Edit")?.withRenderingMode(.alwaysTemplate)
            let editAction = UIAction(title: "Edit", image: editImage) { _ in
                self.goToEdit()
            }
            
            let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: [.destructive]) { _ in
                self.delete()
            }
         
            let menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: [editAction, deleteAction])
            
            return menu
        }
        
        return config
    }
    func goToEdit() {
        
    }
    func delete() {
        
    }
    
}
