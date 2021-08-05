//
//  UITextFieldDelegate+CharacterText.swift
//  RacingCarGame
//
//  Created by Admin on 17.06.21.
//

import UIKit

extension UIViewController: UITextFieldDelegate {
//    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let characterCount = textField.text?.count ?? 0
//        if characterCount > 9 {
//            return false
//        }
//        return true
//    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
