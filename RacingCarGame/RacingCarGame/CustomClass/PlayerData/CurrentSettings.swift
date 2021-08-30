//
//  CurrentSettings.swift
//  RacingCarGame
//
//  Created by Admin on 30.08.21.
//

import Foundation
class CurrentSettings {

    var name: String = "Player"
    var accselerometr: Bool = false
    var speed: Float = 5
    var volumeMus: Float = 1
    var volumeSys: Float = 1
    var oncoming = SkinCars.shared.arrayOncomingCars.randomElement()
    var passing = SkinCars.shared.arrayPassingCars.randomElement()
    var player = SkinCars.shared.arrayPlayerCars.randomElement()

    init(name: String,
         accselerometr: Bool,
         speed: Float,
         volumeMus: Float,
         volumeSys: Float,
         oncoming: String,
         passing: String,
         player: String) {

        self.name = name
        self.accselerometr = accselerometr
        self.speed = speed
        self.volumeMus = volumeMus
        self.volumeSys = volumeSys
        self.oncoming = oncoming
        self.passing = passing
        self.player = player
    }
}
