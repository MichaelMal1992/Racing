//
//  SettingsViewController.swift
//  RacingCarGame
//
//  Created by Admin on 20.05.21.
//

import UIKit
import AVKit
// swiftlint:disable type_body_length
class SettingsViewController: UIViewController {

    @IBOutlet weak private var screenImageView: UIImageView!
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
    @IBOutlet weak private var valueOfAccelerometrLabel: UILabel!
    @IBOutlet weak private var passingCarsLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var oncomingCarsLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var playerCarLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var backgroundBlurEffectView: UIVisualEffectView!
    @IBOutlet weak private var accelerometerSwitch: UISwitch!
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
    @IBOutlet weak var cancelAddNameButton: UIButton!
    private var count = 0
    private var isDidChoose = false
    private var currentPlayerSettings: CurrentSettings?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupLabels()
        setupTextField()
        playTestSystemMusic()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let current = RealmManager.shared.currentPlayer {
            currentPlayerSettings = CurrentSettings(name: current.name,
                                                    accselerometr: current.isStartAccselerometr,
                                                    speed: current.stepFrameSpeed,
                                                    volumeMus: current.volumeMusic,
                                                    volumeSys: current.systemVolume,
                                                    oncoming: current.skins?.oncomingCars ?? "",
                                                    passing: current.skins?.passingCars ?? "",
                                                    player: current.skins?.playerCar ?? "")
        }
        Players.shared.all = RealmManager.shared.allPlayers
        namePlayerLabel.text = RealmManager.shared.currentPlayer?.name
        controlStateSwitch()
        setupSliders()
        playSettingsMusic()
        Sound.settings.play()

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Sound.settings.stop()
        Sound.testSystem.stop()
        currentPlayerSettings = nil
    }

    @IBAction private func speedSliderPressed(_ sender: UISlider) {
        currentPlayerSettings?.speed = Float(CGFloat(sender.value))
        showStatusSpeed(label: valueOfSpeedLabel, value: sender.value)
    }

    @IBAction private func systemVolumeSliderPressed(_ sender: UISlider) {
        currentPlayerSettings?.volumeSys = sender.value
        Sound.testSystem.volume = sender.value
        showStatusVolume(label: valueOfSystemVolumeLabel, value: sender.value)
        Sound.testSystem.play()
    }

    @IBAction private func musicVolumeSliderPressed(_ sender: UISlider) {
        currentPlayerSettings?.volumeMus = sender.value
        Sound.settings.volume = sender.value
        showStatusVolume(label: valueOfMusicVolumeLabel, value: sender.value)
    }

    @IBAction private func cancelAddNameButtonPressed(_ sender: UIButton) {
        cancelAddNameButton.isHidden = true
        namePlayerLabel.text = RealmManager.shared.currentPlayer?.name
        addNameTextField.text?.removeAll()
        addNameTextField.resignFirstResponder()
    }

    @IBAction private func changePlayerButtonPressed(_ sender: UIButton) {
        let name = String(describing: ChangePlayerViewController.self)
        navigationController?.pushViewController(FactoryViewControllers.shared.creat(name), animated: true)
    }

    @IBAction private func accelerometerSwitchPressed(_ sender: UISwitch) {
        if sender.isOn {
            currentPlayerSettings?.accselerometr = true
        } else {
            currentPlayerSettings?.accselerometr = false
        }
        showStatusAccelerometr(label: valueOfAccelerometrLabel, value: sender.isOn)
    }

    @IBAction private func choosePassingCarsButtonPressed(_ sender: UIButton) {
        isDidChoose = false
        chooseCar(RealmManager.shared.currentPlayer?.skins?.passingCars,
                  passingCarsImageView,
                  passingCarsView,
                  passingCarsLeadingConstraint)
    }

    @IBAction private func chooseOncomingCarsButtonPressed(_ sender: UIButton) {
        isDidChoose = false
        chooseCar(RealmManager.shared.currentPlayer?.skins?.oncomingCars,
                  oncomingCarsImageView,
                  oncomingCarsView,
                  oncomingCarsLeadingConstraint)
    }

    @IBAction private func choosePlayerCar(_ sender: UIButton) {
        isDidChoose = false
        chooseCar(RealmManager.shared.currentPlayer?.skins?.playerCar,
                  playerCarImageView,
                  playerCarView,
                  playerCarLeadingConstraint)
    }

    @IBAction private func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction private func saveButtonPressed(_ sender: UIButton) {
        guard let currentPlayer = RealmManager.shared.currentPlayer,
              let playerSettings = currentPlayerSettings else {
            return
        }
        if addNameTextField.isFirstResponder == true {
            createAlert(LocalizableConstants.AlertText.complete)
        } else {
            if playerSettings.name == currentPlayer.name {
                RealmManager.shared.write {
                    currentPlayer.skins?.oncomingCars = playerSettings.oncoming
                    currentPlayer.skins?.passingCars = playerSettings.passing
                    currentPlayer.skins?.playerCar = playerSettings.player
                    currentPlayer.isStartAccselerometr = playerSettings.accselerometr
                    currentPlayer.stepFrameSpeed = playerSettings.speed
                    currentPlayer.volumeMusic = playerSettings.volumeMus
                    currentPlayer.systemVolume = playerSettings.volumeSys
                }
                createAlert(LocalizableConstants.AlertText.successfull)
            } else {
                let newPlayer = PlayerData()
                RealmManager.shared.write {
                    newPlayer.name = playerSettings.name
                    newPlayer.skins?.oncomingCars = playerSettings.oncoming
                    newPlayer.skins?.passingCars = playerSettings.passing
                    newPlayer.skins?.playerCar = playerSettings.player
                    newPlayer.isStartAccselerometr = playerSettings.accselerometr
                    newPlayer.stepFrameSpeed = playerSettings.speed
                    newPlayer.volumeMusic = playerSettings.volumeMus
                    newPlayer.systemVolume = playerSettings.volumeSys
                }
                RealmManager.shared.add(newPlayer)
                UserDefaults.setCurrentName(newPlayer.name)
                createAlert("\(LocalizableConstants.AlertText.player) \(newPlayer.name) \(LocalizableConstants.AlertText.created)")
            }
        }
    }

    @IBAction private func okPassingCarsButtonPressed(_ sender: UIButton) {
        animatingSelected(passingCarsLeadingConstraint)
        if isDidChoose {
            currentPlayerSettings?.passing = SkinCars.shared.arrayPassingCars[count]
        } else {
            return
        }
    }

    @IBAction private func nextPassingCarsButtonPressed(_ sender: UIButton) {
        isDidChoose = true
        next(SkinCars.shared.arrayPassingCars, passingCarsImageView)
    }

    @IBAction private func backPassingCarsButtonPressed(_ sender: UIButton) {
        isDidChoose = true
        back(SkinCars.shared.arrayPassingCars, passingCarsImageView)
    }

    @IBAction private func okOncomingCarsButtonPressed(_ sender: UIButton) {
        animatingSelected(oncomingCarsLeadingConstraint)
        if isDidChoose {
            currentPlayerSettings?.oncoming = SkinCars.shared.arrayOncomingCars[count]
        } else {
            return
        }
    }

    @IBAction private func nextOncomingCarsPressed(_ sender: UIButton) {
        isDidChoose = true
        next(SkinCars.shared.arrayOncomingCars, oncomingCarsImageView)
    }

    @IBAction private func backOncomingCarsButtonPressed(_ sender: UIButton) {
        isDidChoose = true
        back(SkinCars.shared.arrayOncomingCars, oncomingCarsImageView)
    }

    @IBAction private func okPlayerCarButtonPressed(_ sender: UIButton) {
        animatingSelected(playerCarLeadingConstraint)
        if isDidChoose {
            currentPlayerSettings?.player = SkinCars.shared.arrayPlayerCars[count]
        } else {
            return
        }
    }

    @IBAction private func backPlayerCarButtonPressed(_ sender: UIButton) {
        isDidChoose = true
        back(SkinCars.shared.arrayPlayerCars, playerCarImageView)
    }

    @IBAction private func nextPlayerCarButtonPressed(_ sender: UIButton) {
        isDidChoose = true
        next(SkinCars.shared.arrayPlayerCars, playerCarImageView)
    }

    private func chooseCar(_ skin: String?,
                           _ imageView: UIImageView,
                           _ carsView: UIView,
                           _ constraint: NSLayoutConstraint) {
        count = 0
        imageView.image = UIImage(named: skin ?? "")
        constraint.constant = view.center.x + carsView.frame.width / 2
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            self.view.addSubview(self.backgroundBlurEffectView)
            self.view.addSubview(carsView)
            self.backgroundBlurEffectView.alpha = 1
        }
    }

    private func next(_ array: [String], _ imageView: UIImageView) {
        if count < array.count - 1 {
        count += 1
            imageView.image = UIImage(named: array[count])
        } else {
            imageView.image = UIImage(named: array.first ?? "")
            count = 0
        }
    }

    private func back(_ array: [String], _ imageView: UIImageView) {
        if count > 0 {
        count -= 1
            imageView.image = UIImage(named: array[count])
        } else {
            imageView.image = UIImage(named: array.last ?? "")
            count = array.count - 1
        }
    }

    private func animatingSelected(_ constraint: NSLayoutConstraint) {
        constraint.constant = 0
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            self.backgroundBlurEffectView.alpha = 0
        }
    }

    private func setupSliders() {
        speedSlider.maximumValue = 30
        speedSlider.minimumValue = 1
        musicVolumeSlider.maximumValue = 1
        musicVolumeSlider.minimumValue = 0
        systemVolumeSlider.maximumValue = 1
        systemVolumeSlider.minimumValue = 0
        guard let currentPlayer = RealmManager.shared.currentPlayer else {
            return
        }
        speedSlider.setValue(Float(Int(currentPlayer.stepFrameSpeed)), animated: true)
        musicVolumeSlider.setValue(currentPlayer.volumeMusic, animated: true)
        systemVolumeSlider.setValue(currentPlayer.systemVolume, animated: true)
    }

    private func controlStateSwitch() {
        guard let currentPlayer = RealmManager.shared.currentPlayer else {
            return
        }
        if currentPlayer.isStartAccselerometr {
            accelerometerSwitch.setOn(true, animated: true)
        } else {
            accelerometerSwitch.setOn(false, animated: true)
        }
    }

    private func setupTextField() {
        let text = LocalizableConstants.TextField.placeHolder
        let attributed = NSAttributedString(string: text,
                                            attributes: [.foregroundColor: UIColor.gray])
        addNameTextField.attributedPlaceholder = attributed
        addNameTextField.delegate = self
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addNameTextFieldDidChange),
                                               name: UITextField.textDidChangeNotification,
                                               object: addNameTextField)
    }

    @objc private func addNameTextFieldDidChange() {
        if let text = addNameTextField.text {
            let count = text.count
            if count > 12 {
                addNameTextField.text?.removeLast()
            }
            namePlayerLabel.text = addNameTextField.text
        } else {
            namePlayerLabel.text = RealmManager.shared.currentPlayer?.name
        }
    }

    private func setupButtons() {
        cancelAddNameButton.isHidden = true
        saveButton.title = LocalizableConstants.ButtonTitle.save
        backButton.title = LocalizableConstants.ButtonTitle.back
        oncomingCarsButton.title = LocalizableConstants.ButtonTitle.oncoming
        passingCarsButton.title = LocalizableConstants.ButtonTitle.passing
        playerCarButton.title = LocalizableConstants.ButtonTitle.player
        changePlayerButton.title = LocalizableConstants.ButtonTitle.change
        okPlayerCarButton.title = LocalizableConstants.ButtonTitle.okay
        okPassingCarButton.title = LocalizableConstants.ButtonTitle.okay
        okOncomingCarsButton.title = LocalizableConstants.ButtonTitle.okay
        nextPlayerCarButton.title = LocalizableConstants.ButtonTitle.next
        nextPassingCarButton.title = LocalizableConstants.ButtonTitle.next
        nextOncomingCarsButton.title = LocalizableConstants.ButtonTitle.next
        backPlayerCarButton.title = LocalizableConstants.ButtonTitle.backChooseCar
        backOncomingCarsButton.title = LocalizableConstants.ButtonTitle.backChooseCar
        backPassingCarButton.title = LocalizableConstants.ButtonTitle.backChooseCar
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
        nameTextLabel.text = LocalizableConstants.LabelText.name
        accelerometerLabel.text = LocalizableConstants.LabelText.accelerometr
        createPlayerLabel.text = LocalizableConstants.LabelText.create
        carsLabel.text = LocalizableConstants.LabelText.cars
        speedLabel.text = LocalizableConstants.LabelText.speed
        musicVolumeLabel.text = LocalizableConstants.LabelText.music
        systemVolumeLabel.text = LocalizableConstants.LabelText.system
        configurationLabel(nameTextLabel, 25)
        configurationLabel(accelerometerLabel, 25)
        configurationLabel(createPlayerLabel, 25)
        configurationLabel(namePlayerLabel, 40)
        configurationLabel(carsLabel, 25)
        configurationLabel(speedLabel, 25)
        configurationLabel(musicVolumeLabel, 25)
        configurationLabel(systemVolumeLabel, 25)
        guard let currentPlayer = RealmManager.shared.currentPlayer else {
            return
        }
        showStatusVolume(label: valueOfMusicVolumeLabel, value: currentPlayer.volumeMusic)
        showStatusVolume(label: valueOfSystemVolumeLabel, value: currentPlayer.systemVolume)
        showStatusSpeed(label: valueOfSpeedLabel, value: currentPlayer.stepFrameSpeed)
        showStatusAccelerometr(label: valueOfAccelerometrLabel, value: currentPlayer.isStartAccselerometr)
    }

    private func showStatusVolume(label: UILabel, value: Float) {
        if value == 0 {
            label.text = LocalizableConstants.Status.off
        } else {
            if value >= 1 {
                label.text = LocalizableConstants.Status.max
            } else {
                label.text = LocalizableConstants.Status.on
            }
        }
    }

    private func showStatusAccelerometr(label: UILabel, value: Bool) {
        if value {
            label.text = LocalizableConstants.Status.on
        } else {
            label.text = LocalizableConstants.Status.off
        }
    }

    private func showStatusSpeed(label: UILabel, value: Float) {
        if value == 1 {
            label.text = LocalizableConstants.Status.min
        } else {
            if value >= 30 {
                label.text = LocalizableConstants.Status.max
            } else {
                label.text = String(Int(value * 10))
            }
        }
    }

    private func playTestSystemMusic() {
        let urlArray = [Bundle.main.url(forResource: "testSystemMusic", withExtension: "mp3")]
        if let url = urlArray[0],
           let currentPlayer = RealmManager.shared.currentPlayer {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.delegate = self
                player.volume = currentPlayer.systemVolume
                Sound.testSystem = player
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func playSettingsMusic() {
        let urlArray = [Bundle.main.url(forResource: "menuMusic5", withExtension: "mp3")]
        if let url = urlArray[0],
           let currentPlayer = RealmManager.shared.currentPlayer {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.delegate = self
                player.volume = currentPlayer.volumeMusic
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
            if Players.shared.all.first(where: {$0.name == text}) != nil {
                createAlert(LocalizableConstants.AlertText.nameExist)
                addNameTextField.text = text
            } else {
                currentPlayerSettings?.name = text
                controlStateSwitch()
                setupSliders()
            }
        } else {
            createAlert(LocalizableConstants.AlertText.correctName)
            addNameTextField.text?.removeAll()
            namePlayerLabel.text = RealmManager.shared.currentPlayer?.name
            return false
        }
        addNameTextField.resignFirstResponder()
        cancelAddNameButton.isHidden = true
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        cancelAddNameButton.isHidden = false
    }
}
