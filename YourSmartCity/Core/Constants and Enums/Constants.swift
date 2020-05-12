//
//  UIConfiguration.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/11/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation

struct Constants {
    private init() {}
    
    struct Colors {
        private init() {}
        
        struct CGGradientSets {
            private init() {}
            
            static let amin = Constants.Colors.UIGradientSets.amin.map { return $0.cgColor }
            static let stellar = Constants.Colors.UIGradientSets.stellar.map { return $0.cgColor }
            static let rainbowBlue = Constants.Colors.UIGradientSets.rainbowBlue.map { return $0.cgColor }
            static let deepSpace = Constants.Colors.UIGradientSets.deepSpace.map { return $0.cgColor }
        }
        struct UIGradientSets {
            private init() {}
            
            static let amin = [hexStringToUIColor(hex: "#4A00E0"), hexStringToUIColor(hex: "#8E2DE2")]
            static let stellar = [hexStringToUIColor(hex: "#7474BF"), hexStringToUIColor(hex: "#348AC7")]
            static let rainbowBlue = [hexStringToUIColor(hex: "#00F260"), hexStringToUIColor(hex: "#0575E6")]
            static let deepSpace = [hexStringToUIColor(hex: "#000000"), hexStringToUIColor(hex: "#434343")]
        }
        
        struct Statics {
            private init() {}

            static let accentColor = Constants.Colors.hexStringToUIColor(hex: "#5306E0")
        }
        
    }
    
    struct UIConfiguration {
        private init() {}
        
        struct Factors {
            private init() {}
            
            static let collectionCellWidth: CGFloat = 0.8
            static let headerImageHeight: CGFloat = UIScreen.main.bounds.size.height * 0.3
        }
    }
    
    
    struct IDs {
        private init() {}
        
        struct EntryKit {
            private init() {}
            
            static let qrSuccessAlert = "qrSucessAlert"
        }
        
        struct Hero {
            private init() {}
            
            static let scanButton = "scanButton"
            static let targetOutline = "targetOutline"
        }
    }
}



extension Constants.Colors {
    
    private static func hexStringToUIColor (hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
