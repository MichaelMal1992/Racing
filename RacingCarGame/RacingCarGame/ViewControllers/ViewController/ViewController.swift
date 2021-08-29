//
//  ViewController.swift
//  RacingCarGame
//
//  Created by Admin on 20.05.21.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    @IBOutlet weak private var containerForButtonsView: UIView!
    @IBOutlet weak private var startGameButton: UIButton!
    @IBOutlet weak private var settingsButton: UIButton!
    @IBOutlet weak private var scoreButton: UIButton!
    @IBOutlet weak private var exitButton: UIButton!
    @IBOutlet weak private var screenImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        NotificationsManager.shared.push()
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        PlayersManager.shared.players = RealmManager.shared.allPlayers
        if getLastNameValue().isEmpty {
            createAlertWithTextField()
        } else {
            loadingUserDefaults()
        }
        playMenuMusic()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ParalaxManager.shared.start(view, screenImageView)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Sound.menu.stop()
        ParalaxManager.shared.stop()
    }

    private func playMenuMusic() {
        let urlArray = [Bundle.main.url(forResource: "menuMusic4", withExtension: "mp3")]
        if let url = urlArray[0] {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.delegate = self
                player.volume = PlayersManager.shared.currentPlayer.volumeMusic 
                player.play()
                Sound.menu = player
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func loadingUserDefaults() {
        PlayersManager.shared.players = RealmManager.shared.allPlayers
        if let lastName = PlayersManager.shared.players.first(where: {$0.name == getLastNameValue()}) {
            PlayersManager.shared.currentPlayer = lastName
        }
    }

    private func setupButtons() {
        configurationButton(startGameButton, 40)
        configurationButton(scoreButton, 40)
        configurationButton(settingsButton, 40)
        configurationButton(exitButton, 40)
    }

    @IBAction private func startGameButtonPressed(_ sender: Any) {
        let viewcontroller = FactoryViewControllers.shared.creat(String(describing: StartGameViewController.self))
        navigationController?.pushViewController(viewcontroller, animated: true)

    }

    @IBAction private func settingButtonPressed(_ sender: Any) {
        let viewcontroller = FactoryViewControllers.shared.creat(String(describing: SettingsViewController.self))
        navigationController?.pushViewController(viewcontroller, animated: true)
    }

    @IBAction private func scoreButtonPressed(_ sender: Any) {
        let viewcontroller = FactoryViewControllers.shared.creat(String(describing: ScoreViewController.self))
        navigationController?.pushViewController(viewcontroller, animated: true)
    }

    @IBAction private func exitButtonPressed(_ sender: Any) {
        exit(0)
    }
}

extension ViewController: AVAudioPlayerDelegate {

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            playMenuMusic()
        }
    }
}
