//
//  QRSuccessAlertViewController.swift
//  SmartCity QR-scanner
//
//  Created by Alexander Parshakov on 1/31/20.
//  Copyright © 2020 Alexander Parshakov. All rights reserved.
//

import UIKit
import SwiftEntryKit

protocol FromSuccessAlertToScanViewDelegate {
    func alertDidDisappear()
    func didProceedToViewData()
}

class QRSuccessAlert: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var objectImage: UIImageView!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // MARK: - Actions
    @IBAction func onCancelButtonTapped(_ sender: Any) {
        AlertService.hideQRSuccessAndRestart(delegate: delegate)
    }
    @IBAction func onContinueButtonTapped(_ sender: Any) {
        AlertService.hideQRSuccessAndViewData(delegate: delegate)
    }
    
    // MARK: - Variables
    var delegate: FromSuccessAlertToScanViewDelegate?
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("QRSuccessAlert", owner: self, options: nil)
        contentView.fixInView(self)
        setupButtons()
        
        objectImage.layer.cornerRadius = 10
        objectImage.clipsToBounds = true
    }
    private func setupButtons() {
        UIEnhancementService.beautifyAccentView(view: continueButton, cornerRadius: 15)
        UIEnhancementService.beautifyNormalButton(button: cancelButton)
    }
}

extension UIView {
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        container.addSubview(self)
        NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: container, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: -10).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
