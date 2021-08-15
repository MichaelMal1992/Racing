//
//  UIViewController+View.swift
//  RacingCarGame
//
//  Created by Admin on 18.06.21.
//

import UIKit

extension UIViewController {

    func configurationView(_ UIView: UIView, _ originX: CGFloat, _ width: CGFloat) {
        UIView.frame = CGRect(x: originX, y: 0, width: width, height: view.frame.height)
        UIView.backgroundColor = .clear
    }
}
