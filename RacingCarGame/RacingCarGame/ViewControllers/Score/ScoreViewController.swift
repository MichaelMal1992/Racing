//
//  ScoreViewController.swift
//  RacingCarGame
//
//  Created by Admin on 20.05.21.
//

import UIKit
import AVKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var screenImageView: UIImageView!
    @IBOutlet weak private var resetResultsButton: UIButton!
    @IBOutlet weak private var scoresTableView: UITableView!
    @IBOutlet weak private var scoresLabel: UILabel!
    @IBOutlet weak private var backButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        setupButtons()
        scoresTableView.dataSource = self
        PlayersManager.shared.players = PlayersManager.shared.players.sorted(by: {$0.scores > $1.scores })
        let nib = UINib(nibName: String(describing: PlayersScoresTableViewCell.self), bundle: nil)
        scoresTableView.register(nib, forCellReuseIdentifier: String(describing: PlayersScoresTableViewCell.self))
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        playScoresMusic()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Sound.scores.stop()
    }

    private func setupLabels() {
        configurationLabel(scoresLabel, 30)

    }

    private func setupButtons() {
        configurationButton(resetResultsButton, 25)
        configurationButton(backButton, 25)
    }

    private func showAlert() {
    let alert = UIAlertController(title: "Do you want to remove all results?", message: nil, preferredStyle: .alert)
    let actionAlertContinue = UIAlertAction(title: "Continue", style: .default) { (_) in
        self.navigationController?.popToRootViewController(animated: false)
        PlayersManager.shared.currentPlayer.scores = PlayerData().scores
        PlayersManager.shared.currentPlayer.date = PlayerData().date
        PlayersManager.shared.players.removeAll()
        RealmManager.shared.deleteAll()
    }
    let actionAlertCancel = UIAlertAction(title: "Cancel", style: .cancel)
    alert.addAction(actionAlertContinue)
    alert.addAction(actionAlertCancel)
    present(alert, animated: true)
}

    @IBAction private func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction private func resetScoresButtonPressed(_ sender: UIButton) {
        showAlert()
    }

    private func playScoresMusic() {
        let urlArray = [Bundle.main.url(forResource: "menuMusic3", withExtension: "mp3")]
        if let url = urlArray[0] {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.delegate = self
                player.volume = PlayersManager.shared.currentPlayer.volumeMusic 
                player.play()
                Sound.scores = player
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension ScoreViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            playScoresMusic()
        }
    }
}

extension ScoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlayersManager.shared.players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = PlayersScoresTableViewCell.identifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PlayersScoresTableViewCell else {
            return UITableViewCell()
        }
        cell.numberLabel.text = String(indexPath.row + 1)
        cell.dateLabel.text = PlayersManager.shared.players[indexPath.row].date
        cell.nameLabel.text = PlayersManager.shared.players[indexPath.row].name
        cell.scoreLabel.text = String(PlayersManager.shared.players[indexPath.row].scores )
        configurationLabel(cell.numberLabel, 30)
        configurationLabel(cell.nameLabel, 30)
        configurationLabel(cell.scoreLabel, 30)
        configurationLabel(cell.dateLabel, 12)
        if cell.numberLabel.text == "1" {
            cell.numberLabel.textColor = .systemYellow
            cell.numberLabel.font = UIFont(name: "Verdana", size: 40)
        }
        if cell.numberLabel.text == "2" {
            cell.numberLabel.textColor = .lightGray
            cell.numberLabel.font = UIFont(name: "Verdana", size: 40)
        }
        if cell.numberLabel.text == "3" {
            cell.numberLabel.textColor = .systemOrange
            cell.numberLabel.font = UIFont(name: "Verdana", size: 40)
        }
        return cell
    }
}
