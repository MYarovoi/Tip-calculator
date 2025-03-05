//
//  UIResponder+Extension.swift
//  tip-calculator
//
//  Created by Никита Яровой on 05.03.2025.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
