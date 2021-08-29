//
//  ListPlayersViewController.swift
//  RacingCarGame
//
//  Created by Admin on 28.07.21.
//

import UIKit
import AVKit

class ChangePlayerViewController: UIViewController {

    @IBOutlet weak private var screenImageView: UIImageView!
    @IBOutlet weak private var searchTextField: UITextField!
    @IBOutlet weak private var listPlayersTableView: UITableView!
    @IBOutlet weak private var cancelButton: UIButton!
    @IBOutlet weak private var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchTextField()
        configurationButton(cancelButton, 25)
        listPlayersTableView.delegate = self
        listPlayersTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playChangePlayerMusic()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Sound.changePlayer.stop()
    }

    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    private func setupSearchTextField() {
        searchTextField.delegate = self
        hideKeyboardOnTap()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(searchTextFieldDidChange),
                                               name: UITextField.textDidChangeNotification,
                                               object: searchTextField)
    }

    @objc private func searchTextFieldDidChange() {
        if let text = searchTextField.text {
            if text.isEmpty == false {
                let players = RealmManager.shared.allPlayers
                PlayersManager.shared.players = players.filter {$0.name.lowercased().contains(text.lowercased())}
            } else {
                PlayersManager.shared.players = RealmManager.shared.allPlayers
            }
        }
        listPlayersTableView.reloadData()
    }
}

extension ChangePlayerViewController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }

    @objc func handletapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()

    }

    func hideKeyboardOnTap() {
        let tapper = UITapGestureRecognizer(target: self, action: #selector(handletapGestureRecognizer(_:)))
        tapper.delegate = self
        tapper.cancelsTouchesInView = false
        view.addGestureRecognizer(tapper)
    }
}

extension ChangePlayerViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        PlayersManager.shared.players = RealmManager.shared.allPlayers
        listPlayersTableView.reloadData()
        return true
    }

    private func playChangePlayerMusic() {
        let urlArray = [Bundle.main.url(forResource: "menuMusic7", withExtension: "mp3")]
        if let url = urlArray[0] {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.delegate = self
                player.volume = PlayersManager.shared.currentPlayer.volumeMusic
                player.play()
                Sound.changePlayer = player
            } catch {
                print(error.localizedDescription)
            }
        }

    }
}

extension ChangePlayerViewController: AVAudioPlayerDelegate {

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            playChangePlayerMusic()
        }
    }
}

extension ChangePlayerViewController: UITableViewDelegate {

}

extension ChangePlayerViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlayersManager.shared.players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        let name = PlayersManager.shared.players[indexPath.row].name
        let scores = PlayersManager.shared.players[indexPath.row].scores
        cell.textLabel?.text = "\(name):  \(scores) scores"
        configurationLabel(cell.textLabel ?? UILabel(), 30)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PlayersManager.shared.currentPlayer = PlayersManager.shared.players[indexPath.row]
        setLastNameValue()
        navigationController?.popViewController(animated: true)
    }
}
