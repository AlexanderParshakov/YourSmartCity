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
    
    var building = Building()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true);
        self.navigationController?.becomeTransparent()
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromScanToBuilding" {
            let buildingVC = segue.destination as! BuildingViewController
            
            buildingVC.buildingId = self.building.id
        }
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
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
}

// MARK: - Configure UI
extension ScanViewController {
    private func setupTargetOutline() {
        targetOutline.layer.cornerRadius = 20
        targetOutline.alpha = 1
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
        
//        let generator = UIImpactFeedbackGenerator()
//        generator.impactOccurred()
        
        UIView.animate(withDuration: 0.25, animations: {
            self.toggleLoading(withState: true)
        }) { _ in
            guard let idFromQR = Int(object.stringValue ?? "") else { self.reactToInvalidQR(); return }
            NetworkService.Scanning.getBuilding(byId: idFromQR) { [weak self] (result) in
                switch result {
                case .success(let building):
                    self?.targetOutline.alpha = 0
                    if (UIApplication.topViewController() as? ScanViewController) != nil {
                        AlertService.showQRSuccess(viewController: self!, alertTitle: building.name ?? building.fullAddress)
                    }
                    self?.building = building
                    
                    UIView.animate(withDuration: 0.25) {
                        self?.toggleLoading(withState: false)
                    }
                case .failure(let error):
                    AlertService.showScanningInvalid(shortText: "Здание с таким идентификатором не найдено")
                    print("Error: ", error)
                }
            }
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
        self.performSegue(withIdentifier: "fromScanToBuilding", sender: self)
    }
}


// MARK: - Private Methods
extension ScanViewController {
    
    private func toggleLoading(withState state: Bool) {
        if state == true {
            self.targetOutline.backgroundColor = .systemBackground
            self.loadingView.startVioletLoadingAnimation()
            self.statusLabel.isHidden = false
            self.video.opacity = 0.5
        } else {
            self.targetOutline.backgroundColor = .clear
            self.loadingView.isHidden = true
            self.statusLabel.isHidden = true
            self.video.opacity = 1
        }
    }
    
    private func reactToInvalidQR() {
        AlertService.showScanningInvalid(shortText: "Объект с таким QR-кодом не найден")
        toggleLoading(withState: false)
        session.startRunning()
    }
}
