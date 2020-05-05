//
//  Rounding.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/26/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation

extension Float {
    func rounded(rule: NSDecimalNumber.RoundingMode, scale: Int) -> Float {
        var result: Decimal = 0
        var decimalSelf = NSNumber(value: self).decimalValue
        NSDecimalRound(&result, &decimalSelf, scale, rule)
        return (result as NSNumber).floatValue
    }
}
