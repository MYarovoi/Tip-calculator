//
//  ScreenIdentifier.swift
//  tip-calculator
//
//  Created by Никита Яровой on 11.03.2025.
//

import Foundation

enum ScreenIdentifier {
    enum LogoView: String {
        case logoView
    }
    
    enum ResultView: String {
        case totalAmountPerPersonValueLabel
        case totalBillValueLabel
        case totalTipValueLabel
    }
    
    enum BillInputView: String {
        case textField
    }
    
    enum TipInputView: String {
        case tenPercentButton
        case fifteenPercentButton
        case twentyPercentButton
        case customTipButton
        case customTipAlertTextField
    }
    
    enum SplitInputView: String {
        case decrimentButton
        case incrementButton
        case quantityValueLabel
    }
}
