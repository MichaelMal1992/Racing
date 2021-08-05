//
//  UIViewController+MutableStringLabel.swift
//  RacingCarGame
//
//  Created by Admin on 17.06.21.
//

import UIKit

extension UIViewController {

    func configurationLabel(_ label: UILabel, _ size: CGFloat) {
        label.font = UIFont(name: "Marker Felt", size: size)
        label.textColor = .black
        label.backgroundColor = .clear
        label.layer.shadowColor = UIColor.white.cgColor
        label.layer.shadowRadius = 5
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = .zero
    }
}
