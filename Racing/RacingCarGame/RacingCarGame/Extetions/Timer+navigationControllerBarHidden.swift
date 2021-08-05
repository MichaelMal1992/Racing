//
//  Timer+navigationControllerBarHidden.swift
//  RacingCarGame
//
//  Created by Admin on 4.06.21.
//

import UIKit
extension Timer {
    static func addTimerNavigationControllerHidden(withTimeInterval: Double, _ navigationController: UINavigationController?) {
        if let navigation = navigationController {
        Timer.scheduledTimer(withTimeInterval: withTimeInterval, repeats: false) { (timer) in
            navigation.setNavigationBarHidden(true, animated: true)
        }
        }
    }
}
