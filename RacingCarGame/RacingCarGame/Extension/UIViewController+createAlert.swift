//
//  UIViewController+CreateAlert.swift
//  RacingCarGame
//
//  Created by Admin on 29.07.21.
//

import UIKit

extension UIViewController {

    func createAlert(_ text: String) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .cancel))
        present(alert, animated: true)
    }
}
