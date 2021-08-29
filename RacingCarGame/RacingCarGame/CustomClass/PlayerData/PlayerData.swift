//
//  PlayerData.swift
//  RacingCarGame
//
//  Created by Admin on 26.07.21.
//

import UIKit
import RealmSwift

class PlayerData: Object {

    @Persisted var name: String = "Player"
    @Persisted var date: String = "00.00.0000, 00:00"
    @Persisted var scores: Int = 0
    @Persisted var skins: Skins? = Skins()
    @Persisted var isStartAccselerometr: Bool = false
    @Persisted var stepFrameSpeed: Float = 5
    @Persisted var volumeMusic: Float = 1
    @Persisted var systemVolume: Float = 1
}

class Skins: Object {

    @Persisted var oncomingCars = SkinCars.shared.arrayOncomingCars.randomElement()
    @Persisted var passingCars = SkinCars.shared.arrayPassingCars.randomElement()
    @Persisted var playerCar = SkinCars.shared.arrayPlayerCars.randomElement()
}
