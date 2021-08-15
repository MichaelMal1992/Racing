//
//  StartGameViewController+AVAudioDelegate.swift
//  RacingCarGame
//
//  Created by Admin on 15.08.21.
//

import AVKit

extension StartGameViewController: AVAudioPlayerDelegate {

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        switch player {
        case Sound.game:
            if flag {
                Sound.game.play()
            }
        case Sound.move:
            if flag {
                Sound.move.play()
            }
        case Sound.trafic:
            if flag {
                Sound.trafic.play()
            }
        default:
            return
        }
    }
}
