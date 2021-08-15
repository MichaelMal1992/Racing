//
//  StartGameViewController+PlayMusic.swift
//  RacingCarGame
//
//  Created by Admin on 15.08.21.
//

import UIKit
import AVKit

extension StartGameViewController {

    func playGameMusic() {
        var urlArray: [URL?] = []
        for _ in 1...6 {
            urlArray.append(Bundle.main.url(forResource: "gameMusic1", withExtension: "mp3"))
            urlArray.append(Bundle.main.url(forResource: "gameMusic2", withExtension: "mp3"))
            urlArray.append(Bundle.main.url(forResource: "gameMusic3", withExtension: "mp3"))
            urlArray.append(Bundle.main.url(forResource: "gameMusic4", withExtension: "mp3"))
            urlArray.append(Bundle.main.url(forResource: "gameMusic5", withExtension: "mp3"))
            urlArray.append(Bundle.main.url(forResource: "gameMusic6", withExtension: "mp3"))
        }
        if let url = urlArray[Int.random(in: 0...5)] {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.delegate = self
                player.volume = PlayersManager.shared.currentPlayer.volumeMusic
                player.play()
                Sound.game = player
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func playJumpMusic() {
        if let url = Bundle.main.url(forResource: "jump", withExtension: "mp3") {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.volume = PlayersManager.shared.currentPlayer.volumeMusic
                Sound.jump = player
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func playGameOverMusic() {
        if let url = Bundle.main.url(forResource: "gameOverMusic", withExtension: "mp3") {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.volume = PlayersManager.shared.currentPlayer.volumeMusic
                Sound.gameOver = player
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func playSpeedRushMusic() {
        if let url = Bundle.main.url(forResource: "speedRushCar", withExtension: "mp3") {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.volume = PlayersManager.shared.currentPlayer.systemVolume
                Sound.rush = player
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func playStopRushMusic() {
        if let url = Bundle.main.url(forResource: "stopCar", withExtension: "mp3") {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.volume = PlayersManager.shared.currentPlayer.systemVolume
                Sound.stop = player
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func playCrushMusic() {
        if let url = Bundle.main.url(forResource: "carsCrash", withExtension: "mp3") {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.volume = PlayersManager.shared.currentPlayer.systemVolume
                Sound.crash = player
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func playTurnMusic() {
        if let url = Bundle.main.url(forResource: "carTurn", withExtension: "mp3") {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.volume = PlayersManager.shared.currentPlayer.systemVolume
                Sound.turn = player
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func playMoveCarMusic() {
        if let url = Bundle.main.url(forResource: "moveCar", withExtension: "mp3") {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.delegate = self
                player.volume = PlayersManager.shared.currentPlayer.systemVolume
                Sound.move = player
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func playTraficMusic() {
        if let url = Bundle.main.url(forResource: "carsTrafic", withExtension: "mp3") {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.volume = PlayersManager.shared.currentPlayer.volumeMusic
                Sound.trafic = player
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
