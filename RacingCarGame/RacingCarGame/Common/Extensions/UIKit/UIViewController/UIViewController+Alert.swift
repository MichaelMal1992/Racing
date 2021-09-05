//
//  UIViewController+Alert.swift
//  RacingCarGame
//
//  Created by Admin on 26.07.21.
//

import UIKit

extension UIViewController {

    func createAlertWithTextField() {
        let alert = UIAlertController(title: LocalizableConstants.AlertText.enterName,
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addTextField()
        AlertTextField.textField = alert.textFields?.first ?? UITextField()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addNameTextFieldDidChange),
                                               name: UITextField.textDidChangeNotification,
                                               object: AlertTextField.textField)
        AlertTextField.textField.text = "Player"
        alert.addAction(UIAlertAction(title: LocalizableConstants.AlertText.continueOk,
                                      style: .default,
                                      handler: { _ in
            guard let text = AlertTextField.textField.text else {
                return
            }
                if text.isEmpty == false, text != text.filter({ $0 == " "}) {
                    let player = PlayerData()
                    player.name = text
                    RealmManager.shared.add(player)
                    UserDefaults.setCurrentName(text)
                } else {
                    let player = PlayerData()
                    RealmManager.shared.add(player)
                    UserDefaults.setCurrentName(player.name)
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
