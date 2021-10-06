//
//  UIButton+setTitle.swift
//  RacingCarGame
//
//  Created by Admin on 5.09.21.
//

import UIKit

extension UIButton {

    var title: String? {
        get {
            return currentTitle
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }
}
