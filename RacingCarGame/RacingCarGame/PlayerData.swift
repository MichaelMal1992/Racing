//
//  PlayerData.swift
//  RacingCarGame
//
//  Created by Admin on 26.07.21.
//

import UIKit

class PlayerData: Codable {

    var name = "Player"
    var date = "00.00.0000, 00:00"
    var scores = 0
    var skins = Skins()
    var isStartAccselerometr = false
    var stepFrameSpeed: CGFloat = 5
    var volumeMusic: Float = 1
    var systemVolume: Float = 1
}

class Skins: Codable {

    var oncomingCars = SkinCars.shared.arrayOncomingCars.randomElement() ?? ""
    var passingCars = SkinCars.shared.arrayPassingCars.randomElement() ?? ""
    var playerCar = SkinCars.shared.arrayPlayerCars.randomElement() ?? ""
}
