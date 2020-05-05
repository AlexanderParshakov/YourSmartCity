//
//  SensorTableViewCell.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/26/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import UIKit

class SensorTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    
    // MARK: - Constraints
    @IBOutlet weak var statusImageViewWidthConstraint: NSLayoutConstraint!
    
    
    // MARK: Variables
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        wrapperView.setSlightShadow()
        wrapperView.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func set(with sensor: Sensor) {
        nameLabel.text = sensor.title
        valueLabel.text = " \(String(sensor.value.rounded(rule: .bankers, scale: 2))) Вт⋅ч"
        
        let treshold = sensor.standard * 0.8
        
        if sensor.value < treshold {
            statusLabel.text = ""
            statusLabel.textColor = .systemGreen
            statusImageView.image = UIImage(named: "tick")
            statusImageView.changeColor(to: .systemGreen)
        } else if sensor.value >= treshold && sensor.value < sensor.standard {
            statusLabel.text = "Выше среднего"
            statusLabel.textColor = .systemOrange
            statusImageView.image = UIImage(named: "alert")
            statusImageView.changeColor(to: .systemOrange)
        } else {
            statusLabel.text = "Критическое значение"
            statusLabel.textColor = .systemRed
            statusImageView.image = UIImage(named: "alert")
            statusImageView.changeColor(to: .systemRed)

            NotificationService.showCriticalAlert(withTitle: "Внимание!", andMessage: "Критический уровень — электропотребление")
            
            Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(shakeWarning), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc
    private func shakeWarning() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: statusImageView.center.x - 10, y: statusImageView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: statusImageView.center.x + 10, y: statusImageView.center.y))

        statusImageView.layer.add(animation, forKey: "position")
    }
}
