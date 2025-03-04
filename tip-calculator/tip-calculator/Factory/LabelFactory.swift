//
//  LabelFactory.swift
//  tip-calculator
//
//  Created by Никита Яровой on 03.03.2025.
//

import UIKit

struct LabelFactory {
    static func build(text: String?,
                      font: UIFont,
                      backgroumdColor: UIColor = .clear,
                      textColor: UIColor = ThemeColor.text,
                      textAlignment: NSTextAlignment = .center) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.backgroundColor = backgroumdColor
        label.textColor = textColor
        label.textAlignment = textAlignment
        return label
    }
}
