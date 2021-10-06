//
//  ViewController+Shadow.swift
//  RacingCarGame
//
//  Created by Admin on 25.05.21.
//

import UIKit

extension ViewController {

    func shadowButtons(button: UIView) {
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowRadius = 15
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = .init(width: 10, height: 10)
        view.addSubview(button)
    }
}
