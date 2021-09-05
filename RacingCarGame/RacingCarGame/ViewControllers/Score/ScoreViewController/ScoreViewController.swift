//
//  ScoreViewController.swift
//  RacingCarGame
//
//  Created by Admin on 20.05.21.
//

import UIKit
import AVKit
import RxSwift
import RxCocoa

class ScoreViewController: UIViewController {

    @IBOutlet weak private var screenImageView: UIImageView!
    @IBOutlet weak private var resetResultsButton: UIButton!
    @IBOutlet weak private var scoresTableView: UITableView!
    @IBOutlet weak private var scoresLabel: UILabel!
    @IBOutlet weak private var backButton: UIButton!
    private let viewModel = ScoreViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupLabels()
        setupButtons()
        viewModel
            .dataSource
            .bind(to: scoresTableView
                    .rx
                    .items(cellIdentifier: PlayersScoresTableViewCell.identifier,
                           cellType: PlayersScoresTableViewCell.self)) { index, model, cell in
            cell.configure(with: model, index)
        }
        .disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        playScoresMusic()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Sound.scores.stop()
    }

    private func setupLabels() {
        scoresLabel.text = LocalizableConstants.LabelText.scores
        configurationLabel(scoresLabel, 30)

    }

    private func setupButtons() {
        backButton.title = LocalizableConstants.ButtonTitle.back
        resetResultsButton.title = LocalizableConstants.ButtonTitle.reset
        configurationButton(resetResultsButton, 25)
        configurationButton(backButton, 25)
    }

    private func showAlert() {
        let alert = UIAlertController(title: LocalizableConstants.AlertText.remove,
                                      message: nil,
                                      preferredStyle: .alert)
        let actionAlertContinue = UIAlertAction(title: LocalizableConstants.AlertText.continueOk,
                                                style: .default) { (_) in
            self.navigationController?.popToRootViewController(animated: false)
            UserDefaults.setCurrentName("")
            RealmManager.shared.deleteAll()
            Players.shared.all.removeAll()
        }
        let actionAlertCancel = UIAlertAction(title: LocalizableConstants.AlertText.cancel,
                                              style: .cancel)
        alert.addAction(actionAlertContinue)
        alert.addAction(actionAlertCancel)
        present(alert, animated: true)
    }

    private func setupTableView() {
        let nib = UINib(nibName: PlayersScoresTableViewCell.identifier,
                        bundle: nil)
        scoresTableView.register(nib,
                                 forCellReuseIdentifier: PlayersScoresTableViewCell.identifier)
    }

    @IBAction private func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction private func resetScoresButtonPressed(_ sender: UIButton) {
        showAlert()
    }

    private func playScoresMusic() {
        let urlArray = [Bundle.main.url(forResource: "menuMusic3", withExtension: "mp3")]
        if let url = urlArray[0],
           let currentPlayer = RealmManager.shared.currentPlayer {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.delegate = self
                player.volume = currentPlayer.volumeMusic
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
