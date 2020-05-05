//
//  ScanViewController.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/12/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import SwiftEntryKit
import Hero
import Lottie


class ScanViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var targetOutline: UIView!
    @IBOutlet weak var loadingView: AnimationView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    // MARK: - Variables
    var delegate: FromSuccessAlertToScanViewDelegate?
    var video = AVCaptureVideoPreviewLayer()
    let session = AVCaptureSession()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true);
        
        targetOutline.alpha = 0
        cancelButton.alpha = 0
        statusLabel.isHidden = true
        cancelButton.applyGradient(cornerRadius: 10)
        
        
        Hero.shared.defaultAnimation = .selectBy(presenting: .pull(direction: .down), dismissing: .pull(direction: .up))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLayoutSubviews()
        
        initScanning()
        self.view.bringSubviewToFront(targetOutline)
        self.view.bringSubviewToFront(cancelButton)
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { (_) in
            self.setupTargetOutline()
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    // MARK: - Actions
    @IBAction func onCancelButtonTapped(_ sender: Any) {
        SwiftEntryKit.dismiss()
        
        UIView.animate(withDuration: 0.25, animations: {
            self.targetOutline.alpha = 0
            self.targetOutline.backgroundColor = .clear
            self.cancelButton.alpha = 0
        }) { _ in
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { (_) in
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
}

// MARK: - Configure UI
extension ScanViewController {
    private func setupTargetOutline() {
        targetOutline.layer.cornerRadius = 20
        targetOutline.addGradientBorder(borderWidth: 10)
        
        UIView.animate(withDuration: 0.25) {
            self.targetOutline.alpha = 1
            self.cancelButton.alpha = 1
            self.video.opacity = 1
        }
    }
}

// MARK: - Handling Scanning
extension ScanViewController: AVCaptureMetadataOutputObjectsDelegate {
    private func initScanning() {
        
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        
        do {
            if let inputs = session.inputs as? [AVCaptureDeviceInput] {
                for input in inputs {
                    session.removeInput(input)
                }
            }
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        } catch {
            print("Error")
        }
        if let outputs = session.outputs as? [AVCaptureMetadataOutput] {
            for output in outputs {
                session.removeOutput(output)
            }
        }
        let output = AVCaptureMetadataOutput()
        
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: .main)
        output.metadataObjectTypes = [.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.bounds
        video.videoGravity = AVLayerVideoGravity.resizeAspectFill
        view.layer.addSublayer(video)
        
        session.startRunning()
        output.rectOfInterest = video.metadataOutputRectConverted(fromLayerRect: targetOutline.frame)
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard metadataObjects.count != 0 else { return }
        guard let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else { return }
        guard object.type == .qr else { return }
        session.stopRunning()
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)

        UIView.animate(withDuration: 0.25, animations: {
            self.targetOutline.backgroundColor = .systemBackground
            self.loadingView.startVioletLoadingAnimation()
            self.statusLabel.isHidden = false
            self.video.opacity = 0.5
        }) { _ in
            Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false, block: { (_) in
                if (UIApplication.topViewController() as? ScanViewController) != nil {
                    AlertService.showQRSuccess(viewController: self, alertTitle: object.stringValue ?? "Информация найдена")
                }
                UIView.animate(withDuration: 0.25) {
                    self.targetOutline.backgroundColor = .clear
                    self.loadingView.isHidden = true
                    self.statusLabel.isHidden = true
                    self.targetOutline.alpha = 0
                }
            })
        }
        
    }
}


// MARK: Communicating with the Success Alert
extension ScanViewController: FromSuccessAlertToScanViewDelegate {
    func alertDidDisappear() {
        session.startRunning()
        self.setupTargetOutline()
    }
    
    func didProceedToViewData() {
//        let orgListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrganizationListNavigationController") as! UINavigationController
//        self.present(orgListViewController, animated: true, completion: nil)
        self.performSegue(withIdentifier: "fromScanToOrg", sender: self)
    }
}
