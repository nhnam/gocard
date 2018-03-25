//
//  File.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/15/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import Foundation

extension Bool {
    mutating func toggle() {
        self = !self
    }
}

extension Float {
    func decimalString() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self))
    }
    static func fromDecimalString(_ string:String) -> Float {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.number(from: string)?.floatValue ?? 0.0
    }
}
