//
//  StartGameViewController.swift
//  RacingCarGame
//
//  Created by Admin on 20.05.21.
//

import UIKit
import CoreMotion
// swiftlint:disable type_body_length
class StartGameViewController: UIViewController {

    @IBOutlet weak private var mainContainerView: UIView!
    @IBOutlet weak private var menuView: UIView!
    @IBOutlet weak private var trailingMenuConstraint: NSLayoutConstraint!
    @IBOutlet weak private var blurEffectView: UIVisualEffectView!
    @IBOutlet weak private var containerForPauseAndMenuView: UIView!
    @IBOutlet weak private var pauseButton: UIButton!
    @IBOutlet weak private var menuButton: UIButton!
    @IBOutlet weak private var homeButton: UIButton!
    @IBOutlet weak private var exitButton: UIButton!
    @IBOutlet weak private var scoreLabel: UILabel!
    @IBOutlet weak private var playerNameLabel: UILabel!
    @IBOutlet weak private var bestScoreLabel: UILabel!
    @IBOutlet weak private var containerForButtonsView: UIView!
    @IBOutlet weak private var speedometerValueLabel: UILabel!
    private let playerCarImageView = UIImageView()
    private let textGameOverLabel = UILabel()
    private let roadImageView = UIImageView()
    private let secondRoadImageView = UIImageView()
    private let roadView = UIView()
    private let firstRoadLineView = UIView()
    private let secondRoadLineView = UIView()
    private let thirdRoadLineView = UIView()
    private let fourthRoadLineView = UIView()
    private let carOnFirstLineRoadImageView = UIImageView()
    private let carOnSecondLineRoadImageView = UIImageView()
    private let carOnThirdLineRoadImageView = UIImageView()
    private let carOnFourthLineRoadImageView = UIImageView()
    private let motionManager = CMMotionManager()
    private var durationAnimatePlayerCar: Double = 0.5
    private var timeIntervalGameOver: Double = 3
    private var heightCars: CGFloat = 70
    private var widthCars: CGFloat = 35
    private var processingGame = false
    private var isJump = false
    private var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
            configurationLabel(scoreLabel, 22)
            PlayersManager.shared.currentPlayer.stepFrameSpeed += 0.05
            speedometerValueLabel.text = String(format: "%.0f", PlayersManager.shared.currentPlayer.stepFrameSpeed * 10)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRoadView()
        setupLabels()
        setupButtons()
        setupImagesView()
        animateGaming()
        playMoveCarMusic()
        playTraficMusic()
        playSpeedRushMusic()
        playStopRushMusic()
        playCrushMusic()
        playTurnMusic()
        playGameOverMusic()
        playJumpMusic()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moveWithGiro(PlayersManager.shared.currentPlayer.isStartAccselerometr)
        processingGame = true
        Sound.move.play()
        Sound.trafic.play()
        playGameMusic()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        processingGame = false
    }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if processingGame {
            isJump = true
            score -= 5
            view.addSubview(playerCarImageView)
            Sound.jump.currentTime = 0
            Sound.jump.play()
            animateJump()
        } else {
            return
        }
    }

    private func setupMenuView() {
        menuView.layer.cornerRadius = 15
        view.addSubview(menuView)
    }

    private func setupBlurEffectView() {
        view.addSubview(blurEffectView)
    }

    private func setupImagesView() {
        setupRoadsImageView()
        setupPlayerCarImageView()
        setupCarOnFirstLineRoadImageView()
        setupCarOnSecondLineRoadImageView()
        setupCarOnThirdLineRoadImageView()
        setupCarOnFourthLineRoadImageView()
    }

    private func setupPlayerCarImageView() {
        let array = [thirdRoadLineView.center.x - widthCars / 2, fourthRoadLineView.center.x - widthCars / 2]
        let skin = PlayersManager.shared.currentPlayer.skins?.playerCar ?? ""
        configurationImageView(playerCarImageView,
                               UIImage(named: skin) ?? UIImage(),
                               CGRect(x: array.randomElement() ?? 0,
                                      y: view.frame.maxY - heightCars - 20,
                                      width: widthCars,
                                      height: heightCars),
                               nil)
    }

    private func setupCarOnFirstLineRoadImageView() {
        let skin = PlayersManager.shared.currentPlayer.skins?.oncomingCars ?? ""
        configurationImageView(carOnFirstLineRoadImageView,
                               UIImage(named: skin) ?? UIImage(),
                               CGRect(x: firstRoadLineView.center.x - widthCars / 2,
                                      y: -(heightCars * CGFloat(Int.random(in: 1...2))),
                                      width: widthCars,
                                      height: heightCars),
                               nil)
    }

    private func setupCarOnSecondLineRoadImageView() {
        let skin = PlayersManager.shared.currentPlayer.skins?.oncomingCars ?? ""
        configurationImageView(carOnSecondLineRoadImageView,
                               UIImage(named: skin) ?? UIImage(),
                               CGRect(x: secondRoadLineView.center.x - widthCars / 2,
                                      y: -(heightCars * CGFloat(Int.random(in: 3...4))),
                                      width: widthCars,
                                      height: heightCars),
                               nil)
    }

    private func setupCarOnThirdLineRoadImageView() {
        let skin = PlayersManager.shared.currentPlayer.skins?.passingCars ?? ""
        configurationImageView(carOnThirdLineRoadImageView,
                               UIImage(named: skin) ?? UIImage(),
                               CGRect(x: thirdRoadLineView.center.x - widthCars / 2,
                                      y: -(heightCars * CGFloat(Int.random(in: 5...6))),
                                      width: widthCars,
                                      height: heightCars),
                               nil)
    }

    private func setupCarOnFourthLineRoadImageView() {
        let skin = PlayersManager.shared.currentPlayer.skins?.passingCars ?? ""
        configurationImageView(carOnFourthLineRoadImageView,
                               UIImage(named: skin) ?? UIImage(),
                               CGRect(x: fourthRoadLineView.center.x - widthCars / 2,
                                      y: -(heightCars * CGFloat(Int.random(in: 7...8))),
                                      width: widthCars,
                                      height: heightCars),
                               nil)
    }

    private func setupRoadView() {
        let width = view.frame.width * 0.65
        let originX = view.center.x - (view.frame.width * 0.65 / 2) + 1
        let roadsWidth = width / 4
        configurationView(roadView, originX, width)
        configurationView(firstRoadLineView, roadView.frame.minX, roadsWidth)
        configurationView(secondRoadLineView, firstRoadLineView.frame.maxX, roadsWidth)
        configurationView(thirdRoadLineView, secondRoadLineView.frame.maxX, roadsWidth)
        configurationView(fourthRoadLineView, thirdRoadLineView.frame.maxX, roadsWidth)
    }

    private func setupTextGameOverLabel() {
        let origin = CGPoint(x: view.center.x - (textGameOverLabel.frame.width / 2), y: 100)
        let size = CGSize(width: mainContainerView.frame.width, height: 200)
        textGameOverLabel.frame.size = size
        textGameOverLabel.frame.origin = origin
        textGameOverLabel.textAlignment = .center
        textGameOverLabel.text = "GAME OVER!"
        configurationLabel(textGameOverLabel, 40)
        textGameOverLabel.isHidden = true
        view.addSubview(textGameOverLabel)
    }

    private func setupLabels() {
        speedometerValueLabel.text = String(format: "%.0f", PlayersManager.shared.currentPlayer.stepFrameSpeed * 10)
        setupTextGameOverLabel()
        scoreLabel.text = "Score: \(score)"
        playerNameLabel.text = PlayersManager.shared.currentPlayer.name
        bestScoreLabel.text = "Best: \(PlayersManager.shared.currentPlayer.scores)"
        configurationLabel(scoreLabel, 22)
        configurationLabel(playerNameLabel, 22)
        configurationLabel(bestScoreLabel, 22)
        view.addSubview(scoreLabel)
        view.addSubview(playerNameLabel)
        view.addSubview(bestScoreLabel)
    }

    private func setupButtons() {
        containerForPauseAndMenuView.addSubview(pauseButton)
        containerForPauseAndMenuView.addSubview(menuButton)
        configurationButton(pauseButton, 30)
        configurationButton(menuButton, 30)
        configurationButton(homeButton, 40)
        configurationButton(exitButton, 40)
    }

    private func setupRoadsImageView() {
    configurationImageView(roadImageView,
                           UIImage(named: "road_icon") ?? UIImage(),
                           CGRect(x: 0,
                                  y: 0,
                                  width: view.frame.width,
                                  height: view.frame.height),
                           mainContainerView)
        configurationImageView(secondRoadImageView,
                               UIImage(named: "road_icon") ?? UIImage(),
                               CGRect(x: 0,
                                      y: -view.frame.height,
                                      width: view.frame.width,
                                      height: view.frame.height),
                               mainContainerView)
    }

    private func animateGaming() {
        animateRoad()
        animateOncomingCars()
        animatePassingCars()
    }

    private func animateRoad() {
        UIView.animate(withDuration: 0, delay: 0, options: [.curveLinear]) {
            self.roadImageView.frame.origin.y += CGFloat(PlayersManager.shared.currentPlayer.stepFrameSpeed)
            self.secondRoadImageView.frame.origin.y += CGFloat(PlayersManager.shared.currentPlayer.stepFrameSpeed)
            if self.roadImageView.frame.origin.y >= self.view.frame.height {
                self.setupRoadsImageView()
            }
            if self.secondRoadImageView.frame.origin.y >= self.view.frame.height {
                self.setupRoadsImageView()
            }
        } completion: { _ in
            if self.processingGame == true {
                self.animateRoad()
            }
        }
    }

    private func animateJump() {
        UIView.animate(withDuration: 1) {
            self.playerCarImageView.frame.size = CGSize(width: self.widthCars * 2, height: self.heightCars * 2)
            self.playerCarImageView.frame.origin.y -= self.heightCars * 3
        } completion: { _ in
            UIView.animate(withDuration: 1) {
                self.playerCarImageView.frame.size = CGSize(width: self.widthCars, height: self.heightCars)
            } completion: { _ in
                self.isJump = false
            }
        }
    }

    private func animateOncomingCars() {
        UIView.animate(withDuration: 0, delay: 0, options: [.curveLinear], animations: {
            self.carOnFirstLineRoadImageView.frame.origin.y += CGFloat(PlayersManager.shared.currentPlayer.stepFrameSpeed / 1.5)
            self.carOnSecondLineRoadImageView.frame.origin.y += CGFloat(PlayersManager.shared.currentPlayer.stepFrameSpeed / 1.5)
            if self.carOnFirstLineRoadImageView.frame.origin.y >= self.view.frame.maxY {
                self.score += 1
                self.setupCarOnFirstLineRoadImageView()
            }
            if self.carOnSecondLineRoadImageView.frame.origin.y >= self.view.frame.maxY {
                self.score += 1
                self.setupCarOnSecondLineRoadImageView()
            }
            if self.carOnFirstLineRoadImageView.frame.intersects(self.playerCarImageView.frame) {
                if self.isJump == false {
                    Sound.crash.play()
                    self.gameOver()
                }
            }
            if self.carOnSecondLineRoadImageView.frame.intersects(self.playerCarImageView.frame) {
                if self.isJump == false {
                    Sound.crash.play()
                    self.gameOver()
                }
            }
        }, completion: { (_) in
            if self.processingGame == true {
                self.animateOncomingCars()
            }
        })
    }

    private func animatePassingCars() {
        UIView.animate(withDuration: 0, delay: 0, options: [.curveLinear], animations: {
            self.carOnThirdLineRoadImageView.frame.origin.y += CGFloat(PlayersManager.shared.currentPlayer.stepFrameSpeed / 3)
            self.carOnFourthLineRoadImageView.frame.origin.y += CGFloat(PlayersManager.shared.currentPlayer.stepFrameSpeed / 3)
            if self.carOnThirdLineRoadImageView.frame.origin.y >= self.view.frame.maxY {
                self.score += 1
                self.setupCarOnThirdLineRoadImageView()
            }
            if self.carOnFourthLineRoadImageView.frame.origin.y >= self.view.frame.maxY {
                self.score += 1
                self.setupCarOnFourthLineRoadImageView()
            }
            if self.carOnThirdLineRoadImageView.frame.intersects(self.playerCarImageView.frame) {
                if self.isJump == false {
                    Sound.crash.play()
                    self.gameOver()
                }
            }
            if self.carOnFourthLineRoadImageView.frame.intersects(self.playerCarImageView.frame) {
                if self.isJump == false {
                    Sound.crash.play()
                    self.gameOver()
                }
            }
        }, completion: { (_) in
            if self.processingGame == true {
                self.animatePassingCars()
            }
        })
    }

    private func animatePlayerCar(direction: DirectionMove, withDuration: Double) {
        switch direction {
        case .left:
            if processingGame == true {
            UIView.animate(withDuration: withDuration, delay: 0, options: [.curveLinear], animations: {
                if PlayersManager.shared.currentPlayer.isStartAccselerometr {
                    self.playerCarImageView.center.x -= 2
                } else {
                    Sound.turn.currentTime = 0
                    Sound.turn.play()
                    self.playerCarImageView.center.x -= self.firstRoadLineView.frame.width
                }
            }, completion: { (_) in
                if self.playerCarImageView.frame.minX < self.roadView.frame.minX {
                    Sound.crash.play()
                    self.gameOver()
                }
            })
            }
        case .right:
            if processingGame == true {
            UIView.animate(withDuration: withDuration, delay: 0, options: [.curveLinear], animations: {
                if PlayersManager.shared.currentPlayer.isStartAccselerometr {
                    self.playerCarImageView.frame.origin.x += 2
                } else {
                    Sound.turn.currentTime = 0
                    Sound.turn.play()
                    self.playerCarImageView.frame.origin.x += self.firstRoadLineView.frame.width
                }
            }, completion: { (_) in
                if self.playerCarImageView.frame.maxX > self.roadView.frame.maxX {
                    Sound.crash.play()
                    self.gameOver()
                }
            })
            }
        case .top:
            if processingGame == true {
            UIView.animate(withDuration: withDuration, delay: 0, options: [.curveLinear], animations: {
                if PlayersManager.shared.currentPlayer.isStartAccselerometr {
                    self.playerCarImageView.center.y -= 2
                } else {
                    self.playerCarImageView.center.y -= self.heightCars
                }
            }, completion: { (_) in
                if self.playerCarImageView.frame.minY < self.view.frame.minY {
                    Sound.crash.play()
                    self.gameOver()
                }
            })
            }
        case .down:
            if processingGame == true {
            UIView.animate(withDuration: withDuration, delay: 0, options: [.curveLinear], animations: {
                if PlayersManager.shared.currentPlayer.isStartAccselerometr {
                    self.playerCarImageView.center.y += 2
                } else {
                    self.playerCarImageView.center.y += self.heightCars
                }
                if self.playerCarImageView.frame.origin.y >= self.view.frame.maxY - (self.heightCars + 20) {
                    self.playerCarImageView.frame.origin.y = self.view.frame.maxY - (self.heightCars + 20)
                }
            })
            }
        }
    }

    private func moveWithGiro(_ flag: Bool) {
        if flag {
            containerForButtonsView.isHidden = true
            if motionManager.isAccelerometerAvailable {
                motionManager.accelerometerUpdateInterval = 1 / 60
                motionManager.startAccelerometerUpdates(to: .main) { data, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    if let data = data {
                        if data.acceleration.x > 0.08 {
                            self.animatePlayerCar(direction: .right, withDuration: self.durationAnimatePlayerCar)
                        }
                        if data.acceleration.x < -0.08 {
                            self.animatePlayerCar(direction: .left, withDuration: self.durationAnimatePlayerCar)
                        }
                        if data.acceleration.z < -0.8 {
                            self.animatePlayerCar(direction: .top, withDuration: self.durationAnimatePlayerCar)
                        } else {
                            self.animatePlayerCar(direction: .down, withDuration: self.durationAnimatePlayerCar)
                        }
                    }
                }
            }
        } else {
            containerForButtonsView.isHidden = false
            return
        }
    }

    private func gameOver() {
        processingGame = false
        Sound.game.stop()
        Sound.move.stop()
        Sound.trafic.stop()
        Sound.gameOver.play()
        motionManager.stopAccelerometerUpdates()
        setupBlurEffectView()
        setupTextGameOverLabel()
        setupLabels()
        textGameOverLabel.isHidden = false
        UIView.animate(withDuration: 1) {
            self.blurEffectView.alpha = 1
        }
        Timer.scheduledTimer(withTimeInterval: timeIntervalGameOver, repeats: false) { (_) in
            if let navigation = self.navigationController {
            navigation.popToRootViewController(animated: false)
            }
        }
        let players = PlayersManager.shared.players
        let currentPlayer = PlayersManager.shared.currentPlayer
        if let player = players.first(where: {$0.name == currentPlayer.name}) {
            if score > player.scores {
                RealmManager.shared.write {
                    player.scores = self.score
                    player.date = self.getCurentTime()
                }
            } else {
                return
            }
        } else {
            PlayersManager.shared.currentPlayer.scores = score
            PlayersManager.shared.currentPlayer.date = getCurentTime()
            PlayersManager.shared.players.append(PlayersManager.shared.currentPlayer)
            RealmManager.shared.add(PlayersManager.shared.currentPlayer)
        }
    }

    @IBAction func speedRushButtonPressed(_ sender: UIButton) {
        animatePlayerCar(direction: .top, withDuration: durationAnimatePlayerCar)
        Sound.rush.currentTime = 0
        Sound.rush.play()
    }

    @IBAction func stopRushButtonPressed(_ sender: UIButton) {
        animatePlayerCar(direction: .down, withDuration: durationAnimatePlayerCar)
        Sound.stop.currentTime = 0
        Sound.stop.play()
    }

    @IBAction private func moveRightButtonPressed(_ sender: Any) {
        animatePlayerCar(direction: .right, withDuration: durationAnimatePlayerCar)
    }

    @IBAction private func moveLeftButtonPressed(_ sender: Any) {
        animatePlayerCar(direction: .left, withDuration: durationAnimatePlayerCar)
    }

    @IBAction private func pauseButtonPressed(_ sender: UIButton) {
        processingGame = !processingGame
        if processingGame {
            Sound.game.play()
            Sound.move.play()
            Sound.trafic.play()
            sender.setImage(UIImage(systemName: "pause"), for: .normal)
            animateGaming()
        } else {
            Sound.game.pause()
            Sound.move.pause()
            Sound.trafic.pause()
            sender.setImage(UIImage(systemName: "play"), for: .normal)
        }
    }

    @IBAction private func menuButtonPressed(_ sender: UIButton) {
        processingGame = !processingGame
        if processingGame == false || pauseButton.isHidden == false {
            pauseButton.isHidden = true
            processingGame = false
            Sound.game.pause()
            Sound.move.pause()
            Sound.trafic.pause()
            Sound.menu.play()
            setupBlurEffectView()
            setupMenuView()
            view.addSubview(containerForPauseAndMenuView)
            trailingMenuConstraint.constant = mainContainerView.center.x + menuView.frame.width / 2
            UIView.animate(withDuration: 1) {
                self.blurEffectView.alpha = 1
                self.view.layoutIfNeeded()
            }
        } else {
            trailingMenuConstraint.constant = 0
            UIView.animate(withDuration: 1) {
                self.blurEffectView.alpha = 0
                self.view.layoutIfNeeded()
            } completion: { (_) in
                self.pauseButton.isHidden = false
                self.pauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
                self.animateGaming()
                Sound.menu.stop()
                Sound.game.play()
                Sound.move.play()
                Sound.trafic.play()
            }
        }
    }

    @IBAction private func homeButtonPressed(_ sender: UIButton) {
        Sound.menu.stop()
        gameOver()
    }

    @IBAction private func exitButtonPressed(_ sender: UIButton) {
        exit(0)
    }
}
