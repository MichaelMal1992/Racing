//
//  Collors.swift
//  RacingCarGame
//
//  Created by Admin on 29.05.21.
//

import UIKit

class LetterColors {

    static var shared = LetterColors()

    func arrayCollors() -> [UIColor] {
        var array: [UIColor] = []
        for _ in 1...50 {
            array.append(.red)
            array.append(.orange)
        }
        return array
    }
}
