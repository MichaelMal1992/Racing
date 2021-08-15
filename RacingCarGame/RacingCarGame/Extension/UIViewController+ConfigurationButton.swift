//
//  UIViewController+MutableString.swift
//  RacingCarGame
//
//  Created by Admin on 17.06.21.
//

import UIKit

extension UIViewController {

    func configurationButton(_ button: UIButton, _ size: CGFloat) {
    guard let string = button.titleLabel?.text else {
        return
    }
    let newMutableAttributedString = NSMutableAttributedString(string: string)
    var index = 0
    for _ in string {
        newMutableAttributedString.addAttribute(.foregroundColor,
                                                value: LetterColors.shared.arrayCollors()[index],
                                                range: _NSRange(location: index, length: 1))

        index += 1
    }
        newMutableAttributedString.addAttribute(.font,
                                                value: UIFont(name: "Marker Felt", size: size) as Any,
                                                range: _NSRange(location: 0, length: string.count))
        newMutableAttributedString.addAttribute(.backgroundColor,
                                                value: UIColor.black.cgColor,
                                                range: _NSRange(location: 0, length: string.count))

        button.setAttributedTitle(newMutableAttributedString, for: .normal)
        button.alpha = 0.7
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = .zero
    }
}
