//
//  FactoryViewControllers.swift
//  RacingCarGame
//
//  Created by Admin on 20.05.21.
//

import UIKit

class FactoryViewControllers {
    static let shared = FactoryViewControllers()
    func creat (_ identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewControler = storyboard.instantiateViewController(identifier: identifier)
        return viewControler
    }
}
