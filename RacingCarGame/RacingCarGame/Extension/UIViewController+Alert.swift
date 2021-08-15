//
//  UIViewController+Alert.swift
//  RacingCarGame
//
//  Created by Admin on 26.07.21.
//

import UIKit

extension UIViewController {

    func createAlertWithTextField() {
        let alert = UIAlertController(title: "Enter your name", message: nil, preferredStyle: .alert)
        alert.addTextField()
        AlertTextField.textField = alert.textFields?.first ?? UITextField()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addNameTextFieldDidChange),
                                               name: UITextField.textDidChangeNotification,
                                               object: AlertTextField.textField)
        AlertTextField.textField.text = PlayerData().name
        alert.addAction(UIAlertAction(title: "Continuet", style: .default, handler: { _ in
            guard let text = AlertTextField.textField.text else {
                return
            }
                if text.isEmpty == false, text != text.filter({ $0 == " "}) {
                    PlayersManager.shared.currentPlayer.name = text
                    self.setLastNameValue()
                } else {
                    PlayersManager.shared.currentPlayer.name = PlayerData().name
                    self.setLastNameValue()
                }
        }))
        present(alert, animated: true)
    }

    @objc private func addNameTextFieldDidChange() {
        let characterCount = AlertTextField.textField.text?.count ?? 0
        if characterCount > 12 {
            AlertTextField.textField.text?.removeLast()
        } else {
        }
    }
}
