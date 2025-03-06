//
//  Double+Extension.swift
//  tip-calculator
//
//  Created by Никита Яровой on 06.03.2025.
//

import Foundation

extension Double {
    var currencyFormated: String {
        var isWholeNumber: Bool {
            isZero ? true: !isNormal ? false: self == rounded()
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
        return formatter.string(for: self) ?? ""
    }
}
