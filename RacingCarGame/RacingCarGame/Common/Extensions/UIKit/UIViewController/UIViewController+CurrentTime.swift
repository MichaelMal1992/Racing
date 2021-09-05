//
//  Date+NowTime.swift
//  RacingCarGame
//
//  Created by Admin on 19.06.21.
//

import UIKit

extension UIViewController {

    func getCurentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "ru")
        let date = dateFormatter.string(from: Date())
        return date
    }
}
