//
//  AlertService.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/12/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation
import SwiftEntryKit

final class AlertService {
    static func showQRSuccess(viewController: FromSuccessAlertToScanViewDelegate, alertTitle title: String) {
        guard !SwiftEntryKit.isCurrentlyDisplaying else { return }
        
        var attributes = EKAttributes.centerFloat
        attributes.name = Constants.IDs.EntryKit.qrSuccessAlert
        
        attributes.entranceAnimation = .init(
            translate: .init(duration: 0.5, anchorPosition: .top, spring: .init(damping: 1, initialVelocity: 0)),
            scale: .init(from: 0.8, to: 1, duration: 0.5),
            fade: .init(from: 0.8, to: 1, duration: 0.3))
        
        attributes.windowLevel = .normal
        attributes.position = .center
        attributes.displayDuration = .infinity
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: false, pullbackAnimation: .jolt)
        
        attributes.entryBackground = .color(color: .standardBackground)
        attributes.hapticFeedbackType = .success
        attributes.roundCorners = .all(radius: 15)
        let contentView = QRSuccessAlert()
        contentView.titleLabel.text = title
        contentView.delegate = viewController
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    static func hideQRSuccessAndRestart(delegate: FromSuccessAlertToScanViewDelegate?) {
        SwiftEntryKit.dismiss(.specific(entryName: Constants.IDs.EntryKit.qrSuccessAlert)) {
            delegate?.alertDidDisappear()
        }
    }
    static func hideQRSuccessAndViewData(delegate: FromSuccessAlertToScanViewDelegate?) {
        SwiftEntryKit.dismiss(.specific(entryName: Constants.IDs.EntryKit.qrSuccessAlert)) {
            delegate?.didProceedToViewData()
        }
    }
    
    static func showChangeThemeSuccess() {
        // Generate top floating entry and set some properties
        var attributes = EKAttributes.toast
        attributes.entryBackground = .gradient(gradient: .init(
            colors: [EKColor(Constants.Colors.UIGradientSets.rainbowBlue[0]), EKColor(Constants.Colors.UIGradientSets.rainbowBlue[1])],
            startPoint: .zero,
            endPoint: CGPoint(x: 1, y: 1)))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3), scale: .init(from: 1, to: 0.7, duration: 0.7)))
//        attributes.entranceAnimation = .init(
//            translate: .init(duration: 0.5, anchorPosition: .top, spring: .init(damping: 1, initialVelocity: 0)),
//            scale: .init(from: 0.8, to: 1, duration: 0.5),
//            fade: .init(from: 0.8, to: 1, duration: 0.3))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
        attributes.statusBar = .dark
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.hapticFeedbackType = .success
        attributes.screenBackground = .visualEffect(style: .standard)
        attributes.displayDuration = 0.8
        
        
        let title = EKProperty.LabelContent(text: "Тема успешно изменена", style: .init(font: .boldSystemFont(ofSize: 22), color: .white))
        let description = EKProperty.LabelContent(text: "", style: .init(font: .systemFont(ofSize: 17), color: .standardBackground))
        
        let origImage = UIImage(named: "Checkmark")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        let image = EKProperty.ImageContent(image: tintedImage!, size: CGSize(width: 40, height: 40), tint: .init(light: .white, dark: .white))
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
}

