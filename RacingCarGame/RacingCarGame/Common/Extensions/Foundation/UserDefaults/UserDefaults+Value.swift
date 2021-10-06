//
//  UIViewController+Codable.swift
//  RacingCarGame
//
//  Created by Admin on 20.06.21.
//

import UIKit

extension UserDefaults {

    static func setCurrentName(_ name: String) {
        UserDefaults.standard.setValue(name, forKey: "Current_Player")
    }

    static func getCurrentName() -> String {
        let name = UserDefaults.standard.value(forKey: "Current_Player") as? String ?? ""
        return name
    }

}
