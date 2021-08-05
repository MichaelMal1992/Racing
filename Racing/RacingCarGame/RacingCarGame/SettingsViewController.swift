//
//  SettingsViewController.swift
//  RacingCarGame
//
//  Created by Admin on 20.05.21.
//

import UIKit
import AVKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var screenImageView: UIImageView!
    @IBOutlet weak private var passingCarsView: UIView!
    @IBOutlet weak private var passingCarsImageView: UIImageView!
    @IBOutlet weak private var oncomingCarsView: UIView!
    @IBOutlet weak private var oncomingCarsImageView: UIImageView!
    @IBOutlet weak private var playerCarView: UIView!
    @IBOutlet weak private var playerCarImageView: UIImageView!
    @IBOutlet weak private var addNameTextField: UITextField!
    @IBOutlet weak private var saveButton: UIButton!
    @IBOutlet weak private var backButton: UIButton!
    @IBOutlet weak private var passingCarsButton: UIButton!
    @IBOutlet weak private var oncomingCarsButton: UIButton!
    @IBOutlet weak private var playerCarButton: UIButton!
    @IBOutlet weak private var changePlayerButton: UIButton!
    @IBOutlet weak private var okOncomingCarsButton: UIButton!
    @IBOutlet weak private var backOncomingCarsButton: UIButton!
    @IBOutlet weak private var nextOncomingCarsButton: UIButton!
    @IBOutlet weak private var okPlayerCarButton: UIButton!
    @IBOutlet weak private var backPlayerCarButton: UIButton!
    @IBOutlet weak private var nextPlayerCarButton: UIButton!
    @IBOutlet weak private var okPassingCarButton: UIButton!
    @IBOutlet weak private var nextPassingCarButton: UIButton!
    @IBOutlet weak private var backPassingCarButton: UIButton!
    @IBOutlet weak private var nameTextLabel: UILabel!
    @IBOutlet weak private var accelerometerLabel: UILabel!
    @IBOutlet weak private var passingCarsLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var oncomingCarsLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var playerCarLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var backgroundBlurEffectView: UIVisualEffectView!
    @IBOutlet weak private var accelerometerSwitch: UISwitch!
    @IBOutlet weak private var widthCancelButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak private var namePlayerLabel: UILabel!
    @IBOutlet weak private var createPlayerLabel: UILabel!
    @IBOutlet weak private var speedLabel: UILabel!
    @IBOutlet weak private var carsLabel: UILabel!
    @IBOutlet weak private var speedSlider: UISlider!
    @IBOutlet weak private var valueOfSpeedLabel: UILabel!
    @IBOutlet weak private var musicVolumeLabel: UILabel!
    @IBOutlet weak private var musicVolumeSlider: UISlider!
    @IBOutlet weak private var valueOfMusicVolumeLabel: UILabel!
    @IBOutlet weak private var systemVolumeLabel: UILabel!
    @IBOutlet weak private var valueOfSystemVolumeLabel: UILabel!
    @IBOutlet weak private var systemVolumeSlider: UISlider!
    private var count = 0
    private var isDidChoose = false

    override func viewDidLoad() {
        super.viewDidLoad()

        widthCancelButtonConstraint.constant = 0
        hideKeyboardOnTap()
        setupButtons()
        setupLabels()
        setupTextField()
        playSettingsMusic()
        playTestSystemMusic()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        PlayersManager.shared.players = decodingData(getDataValue())
        namePlayerLabel.text = getLastNameValue()
        controlStateSwitch()
        setupSliders()
        Sound.settings.play()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Sound.settings.stop()
    }

    @IBAction private func speedSliderPressed(_ sender: UISlider) {
        valueOfSpeedLabel.text = String(Int(sender.value) * 10)
        PlayersManager.shared.currentPlayer.stepFrameSpeed = CGFloat(Int(sender.value))
    }

    @IBAction func systemVolumeSliderPressed(_ sender: UISlider) {
        setSystemVolume(sender, valueOfSystemVolumeLabel)
        Sound.testSystem.volume = PlayersManager.shared.currentPlayer.systemVolume
        Sound.testSystem.play()
    }

    @IBAction private func musicVolumeSliderPressed(_ sender: UISlider) {
        setMusicVolume(sender, valueOfMusicVolumeLabel)
        Sound.settings.volume = PlayersManager.shared.currentPlayer.volumeMusic
    }

    @IBAction private func cancelAddNameButtonPressed(_ sender: UIButton) {
        namePlayerLabel.text = getLastNameValue()
        addNameTextField.text?.removeAll()
        addNameTextField.resignFirstResponder()
        widthCancelButtonConstraint.constant = 0
    }

    @IBAction private func changePlayerButtonPressed(_ sender: UIButton) {
        navigationController?.pushViewController(FactoryViewControllers.shared.creat(String(describing: ChangePlayerViewController.self)), animated: true)
    }

    @IBAction private func accelerometerSwitchPressed(_ sender: UISwitch) {
        if sender.isOn {
            PlayersManager.shared.currentPlayer.isStartAccselerometr = true
        } else {
            PlayersManager.shared.currentPlayer.isStartAccselerometr = false
        }
    }

    @IBAction private func choosePassingCarsButtonPressed(_ sender: UIButton) {
        isDidChoose = false
        count = 0
        passingCarsImageView.image = UIImage(named: PlayersManager.shared.currentPlayer.skins.passingCars)
        passingCarsLeadingConstraint.constant = view.center.x + passingCarsView.frame.width / 2
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            self.view.addSubview(self.backgroundBlurEffectView)
            self.setupPassingCarsView()
            self.backgroundBlurEffectView.alpha = 1
        }
    }
    @IBAction private func chooseOncomingCarsButtonPressed(_ sender: UIButton) {
        isDidChoose = false
        count = 0
        oncomingCarsImageView.image = UIImage(named: PlayersManager.shared.currentPlayer.skins.oncomingCars)
        oncomingCarsLeadingConstraint.constant = view.center.x + oncomingCarsView.frame.width / 2
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            self.view.addSubview(self.backgroundBlurEffectView)
            self.setupOncomingCarsView()
            self.backgroundBlurEffectView.alpha = 1
        }
    }
    @IBAction private func choosePlayerCar(_ sender: UIButton) {
        isDidChoose = false
        count = 0
        playerCarImageView.image = UIImage(named: PlayersManager.shared.currentPlayer.skins.playerCar)
        playerCarLeadingConstraint.constant = view.center.x + playerCarView.frame.width / 2
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            self.view.addSubview(self.backgroundBlurEffectView)
            self.setupPlayerCarView()
            self.backgroundBlurEffectView.alpha = 1
        }
    }

    @IBAction private func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction private func saveButtonPressed(_ sender: UIButton) {
        if addNameTextField.isFirstResponder == true {
            createAlert("Complete name input")
        } else {
            if let player = PlayersManager.shared.players.first(where: {$0.name == PlayersManager.shared.currentPlayer.name}) {
                player.skins = PlayersManager.shared.currentPlayer.skins
                player.isStartAccselerometr = PlayersManager.shared.currentPlayer.isStartAccselerometr
                player.stepFrameSpeed = PlayersManager.shared.currentPlayer.stepFrameSpeed
                player.volumeMusic = PlayersManager.shared.currentPlayer.volumeMusic
                player.systemVolume = PlayersManager.shared.currentPlayer.systemVolume
                setDataValue(encodingData(PlayersManager.shared.players))
                setLastNameValue()
                createAlert("New settings saved successfully")
            } else {
                PlayersManager.shared.players.append(PlayersManager.shared.currentPlayer)
                setDataValue(encodingData(PlayersManager.shared.players))
                setLastNameValue()
                createAlert("\(PlayersManager.shared.currentPlayer.name) was be created")
            }
        }
    }

    @IBAction private func okPassingCarsButtonPressed(_ sender: UIButton) {
        passingCarsLeadingConstraint.constant = 0
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            self.backgroundBlurEffectView.alpha = 0
        }
        if isDidChoose {
            PlayersManager.shared.currentPlayer.skins.passingCars = SkinCars.shared.arrayPassingCars[count]
        } else {
            return
        }
    }

    @IBAction private func nextPassingCarsButtonPressed(_ sender: UIButton) {
        isDidChoose = true
        if count < SkinCars.shared.arrayPassingCars.count - 1 {
        count += 1
        passingCarsImageView.image = UIImage(named: SkinCars.shared.arrayPassingCars[count])
        } else {
            passingCarsImageView.image = UIImage(named: SkinCars.shared.arrayPassingCars.first ?? "")
            count = 0
        }
    }

    @IBAction private func backPassingCarsButtonPressed(_ sender: UIButton) {
        isDidChoose = true
        if count > 0 {
        count -= 1
        passingCarsImageView.image = UIImage(named: SkinCars.shared.arrayPassingCars[count])
        } else {
            passingCarsImageView.image = UIImage(named: SkinCars.shared.arrayPassingCars.last ?? "")
            count = SkinCars.shared.arrayPassingCars.count - 1
        }
    }

    @IBAction private func okOncomingCarsButtonPressed(_ sender: UIButton) {
        oncomingCarsLeadingConstraint.constant = 0
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            self.backgroundBlurEffectView.alpha = 0
        }
        if isDidChoose {
            PlayersManager.shared.currentPlayer.skins.oncomingCars = SkinCars.shared.arrayOncomingCars[count]
        } else {
            return
        }
    }

    @IBAction private func nextOncomingCarsPressed(_ sender: UIButton) {
        isDidChoose = true
        if count < SkinCars.shared.arrayOncomingCars.count - 1 {
        count += 1
        oncomingCarsImageView.image = UIImage(named: SkinCars.shared.arrayOncomingCars[count])
        } else {
            oncomingCarsImageView.image = UIImage(named: SkinCars.shared.arrayOncomingCars.first ?? "")
            count = 0
        }
    }

    @IBAction private func backOncomingCarsButtonPressed(_ sender: UIButton) {
        isDidChoose = true
        if count > 0 {
        count -= 1
            oncomingCarsImageView.image = UIImage(named: SkinCars.shared.arrayOncomingCars[count])
        } else {
            oncomingCarsImageView.image = UIImage(named: SkinCars.shared.arrayOncomingCars.last ?? "")
            count = SkinCars.shared.arrayOncomingCars.count - 1
        }
    }

    @IBAction private func okPlayerCarButtonPressed(_ sender: UIButton) {
        playerCarLeadingConstraint.constant = 0
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            self.backgroundBlurEffectView.alpha = 0
        }
        if isDidChoose {
            PlayersManager.shared.currentPlayer.skins.playerCar = SkinCars.shared.arrayPlayerCars[count]
        } else {
            return
        }
    }

    @IBAction private func backPlayerCarButtonPressed(_ sender: UIButton) {
        isDidChoose = true
        if count > 0 {
        count -= 1
        playerCarImageView.image = UIImage(named: SkinCars.shared.arrayPlayerCars[count])
        } else {
            playerCarImageView.image = UIImage(named: SkinCars.shared.arrayPlayerCars.last ?? "")
            count = SkinCars.shared.arrayPlayerCars.count - 1
        }
    }

    @IBAction private func nextPlayerCarButtonPressed(_ sender: UIButton) {
        isDidChoose = true
        if count < SkinCars.shared.arrayPlayerCars.count - 1 {
        count += 1
            playerCarImageView.image = UIImage(named: SkinCars.shared.arrayPlayerCars[count])
        } else {
            playerCarImageView.image = UIImage(named: SkinCars.shared.arrayPlayerCars.first ?? "")
            count = 0
        }
    }

    private func setupSliders() {
        speedSlider.maximumValue = 20
        speedSlider.minimumValue = 1
        musicVolumeSlider.maximumValue = 10
        musicVolumeSlider.minimumValue = 0
        systemVolumeSlider.maximumValue = 10
        systemVolumeSlider.minimumValue = 0
        speedSlider.setValue(Float(Int(PlayersManager.shared.currentPlayer.stepFrameSpeed)), animated: true)
        getVolume(PlayersManager.shared.currentPlayer.volumeMusic, musicVolumeSlider)
        getVolume(PlayersManager.shared.currentPlayer.systemVolume, systemVolumeSlider)
        valueOfSpeedLabel.text = String(Int(speedSlider.value) * 10)
        valueOfMusicVolumeLabel.text = String(Int(musicVolumeSlider.value))
        valueOfSystemVolumeLabel.text = String(Int(systemVolumeSlider.value))
    }

    private func controlStateSwitch() {
        if PlayersManager.shared.currentPlayer.isStartAccselerometr == true {
            accelerometerSwitch.setOn(true, animated: true)
        } else {
            accelerometerSwitch.setOn(false, animated: true)
        }
    }

    private func setupTextField() {
        addNameTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(addNameTextFieldDidChange), name: UITextField.textDidChangeNotification, object: addNameTextField)
    }

    @objc private func addNameTextFieldDidChange() {
        if let text = addNameTextField.text {
            let count = text.count
            if count > 12 {
                addNameTextField.text?.removeLast()
            }
            namePlayerLabel.text = addNameTextField.text
        } else {
            namePlayerLabel.text = getLastNameValue()
        }
    }

    private func setupButtons() {

        configurationButton(saveButton, 25)
        configurationButton(backButton, 25)
        configurationButton(oncomingCarsButton, 20)
        configurationButton(passingCarsButton, 20)
        configurationButton(playerCarButton, 20)
        configurationButton(changePlayerButton, 25)
        configurationButton(okPlayerCarButton, 25)
        configurationButton(okPassingCarButton, 25)
        configurationButton(okOncomingCarsButton, 25)
        configurationButton(backPlayerCarButton, 25)
        configurationButton(backPassingCarButton, 25)
        configurationButton(backOncomingCarsButton, 25)
        configurationButton(nextPlayerCarButton, 25)
        configurationButton(nextPassingCarButton, 25)
        configurationButton(nextOncomingCarsButton, 25)
    }

    private func setupLabels() {
        configurationLabel(nameTextLabel, 25)
        configurationLabel(accelerometerLabel, 25)
        configurationLabel(createPlayerLabel, 25)
        configurationLabel(namePlayerLabel, 40)
        configurationLabel(carsLabel, 25)
        configurationLabel(speedLabel, 25)
        configurationLabel(musicVolumeLabel, 25)
        configurationLabel(systemVolumeLabel, 25)
    }

    private func setupPassingCarsView() {
        view.addSubview(passingCarsView)
    }

    private func setupOncomingCarsView() {
        view.addSubview(oncomingCarsView)
    }

    private func setupPlayerCarView() {
        view.addSubview(playerCarView)
    }

    private func playTestSystemMusic() {
        let urlArray = [Bundle.main.url(forResource: "testSystemMusic", withExtension: "mp3")]
        if let url = urlArray[0] {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.delegate = self
                player.volume = PlayersManager.shared.currentPlayer.systemVolume
                Sound.testSystem = player
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func playSettingsMusic() {
        let urlArray = [Bundle.main.url(forResource: "menuMusic5", withExtension: "mp3")]
        if let url = urlArray[0] {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.delegate = self
                player.volume = PlayersManager.shared.currentPlayer.volumeMusic
                Sound.settings = player
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension SettingsViewController: AVAudioPlayerDelegate {

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            Sound.settings.play()
        }
    }
}

extension SettingsViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = addNameTextField.text else {
            return false
        }
        if text.isEmpty == false, text != text.filter({ $0 == " "}) {
            if PlayersManager.shared.players.first(where: {$0.name == text}) != nil {
                createAlert("This name already exists")
                addNameTextField.text = text
            } else {
                PlayersManager.shared.currentPlayer = PlayerData()
                PlayersManager.shared.currentPlayer.name = text
                controlStateSwitch()
                setupSliders()
            }
        } else {
            createAlert("Enter correct name")
            addNameTextField.text?.removeAll()
            namePlayerLabel.text = getLastNameValue()
            return false
        }
        addNameTextField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        widthCancelButtonConstraint.constant = 60
    }
}

extension SettingsViewController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }

    @objc func handletapGestureRecognizer(_ sender: UITapGestureRecognizer) {

    }

    func hideKeyboardOnTap() {
        let tapper = UITapGestureRecognizer(target: self, action: #selector(handletapGestureRecognizer(_:)))
        tapper.delegate = self
        tapper.cancelsTouchesInView = false
        view.addGestureRecognizer(tapper)
    }
}

extension SettingsViewController {

    func getVolume(_ volume: Float, _ slider: UISlider) {
        if volume == 0 {
            slider.setValue(0, animated: true)
        }
        if volume == 0.001 {
            slider.setValue(1, animated: true)
        }
        if volume == 0.005 {
            slider.setValue(2, animated: true)
        }
        if volume == 0.008 {
            slider.setValue(3, animated: true)
        }
        if volume == 0.01 {
            slider.setValue(4, animated: true)
        }
        if volume == 0.05 {
            slider.setValue(5, animated: true)
        }
        if volume == 0.08 {
            slider.setValue(6, animated: true)
        }
        if volume == 0.1 {
            slider.setValue(7, animated: true)
        }
        if volume == 0.5 {
            slider.setValue(8, animated: true)
        }
        if volume == 0.8 {
            slider.setValue(9, animated: true)
        }
        if volume == 1 {
            slider.setValue(10, animated: true)
        }
    }

    func setSystemVolume(_ slider: UISlider, _ label: UILabel) {
        for number in 0...10 {
            if Int(slider.value) == number {
                slider.value = Float(number)
                if number == 0 {
                    PlayersManager.shared.currentPlayer.systemVolume = 0
                }
                if number == 1 {
                    PlayersManager.shared.currentPlayer.systemVolume = 0.001
                }
                if number == 2 {
                    PlayersManager.shared.currentPlayer.systemVolume = 0.005
                }
                if number == 3 {
                    PlayersManager.shared.currentPlayer.systemVolume = 0.008
                }
                if number == 4 {
                    PlayersManager.shared.currentPlayer.systemVolume = 0.01
                }
                if number == 5 {
                    PlayersManager.shared.currentPlayer.systemVolume = 0.05
                }
                if number == 6 {
                    PlayersManager.shared.currentPlayer.systemVolume = 0.08
                }
                if number == 7 {
                    PlayersManager.shared.currentPlayer.systemVolume = 0.1
                }
                if number == 8 {
                    PlayersManager.shared.currentPlayer.systemVolume = 0.5
                }
                if number == 9 {
                    PlayersManager.shared.currentPlayer.systemVolume = 0.8
                }
                if number == 10 {
                    PlayersManager.shared.currentPlayer.systemVolume = 1
                }
                label.text = String(number)
            }
        }
    }

    func setMusicVolume(_ slider: UISlider, _ label: UILabel) {
        for number in 0...10 {
            if Int(slider.value) == number {
                slider.value = Float(number)
                if number == 0 {
                    PlayersManager.shared.currentPlayer.volumeMusic = 0
                }
                if number == 1 {
                    PlayersManager.shared.currentPlayer.volumeMusic = 0.001
                }
                if number == 2 {
                    PlayersManager.shared.currentPlayer.volumeMusic = 0.005
                }
                if number == 3 {
                    PlayersManager.shared.currentPlayer.volumeMusic = 0.008
                }
                if number == 4 {
                    PlayersManager.shared.currentPlayer.volumeMusic = 0.01
                }
                if number == 5 {
                    PlayersManager.shared.currentPlayer.volumeMusic = 0.05
                }
                if number == 6 {
                    PlayersManager.shared.currentPlayer.volumeMusic = 0.08
                }
                if number == 7 {
                    PlayersManager.shared.currentPlayer.volumeMusic = 0.1
                }
                if number == 8 {
                    PlayersManager.shared.currentPlayer.volumeMusic = 0.5
                }
                if number == 9 {
                    PlayersManager.shared.currentPlayer.volumeMusic = 0.8
                }
                if number == 10 {
                    PlayersManager.shared.currentPlayer.volumeMusic = 1
                }
                label.text = String(number)
            }
        }
    }
}
