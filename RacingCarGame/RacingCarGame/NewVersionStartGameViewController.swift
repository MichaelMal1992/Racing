////
////  StartGameViewController.swift
////  RacingCarGame
////
////  Created by Admin on 20.05.21.
////
//
//import UIKit
//
//class StartGameViewController: UIViewController {
//
//    @IBOutlet weak private var mainContainerView: UIView!
//    private let roadImageView = UIImageView()
//    private let secondRoadImageView = UIImageView()
//    private let roadView = UIView()
//    private let firstRoadLineView = UIView()
//    private let secondRoadLineView = UIView()
//    private let thirdRoadLineView = UIView()
//    private let fourthRoadLineView = UIView()
//
//    @IBOutlet weak var menuView: UIView!
//    @IBOutlet weak var trailingMenuConstraint: NSLayoutConstraint!
//
//    @IBOutlet weak var blurEffectView: UIVisualEffectView!
//
//    private let carImageView = UIImageView()
//
//    @IBOutlet weak var containerForPauseAndMenuView: UIView!
//
//    @IBOutlet weak var pauseButton: UIButton!
//
//    @IBOutlet weak private var moveRightButton: UIButton!
//    @IBOutlet weak private var moveLeftButton: UIButton!
//
//    private let textGameOverLabel = UILabel()
//
//    @IBOutlet weak var scoreLabel: UILabel!
//
//    @IBOutlet weak var playerNameLabel: UILabel!
//
//    @IBOutlet weak private var containerForButtonsView: UIView!
//
//    private let oncomingCar = UIImageView()
//    private let oncomingCarTwo = UIImageView()
//    private let oncomingCarThree = UIImageView()
//
//    private var withDurationRoad: Double = 0.05
//    private var delayRoad: Double = 0
//    private var withDurationOncomingCar: Double = 0.01
//    private var delayOncomingCar: Double = 0
//    private var stepOncomingCar: CGFloat = 4
//    private var withDurationCar: Double = 0.5
//    private var withTimeIntervalGameOver: Double = 2
//    private var heightCars: CGFloat = 90
//    private var widthCars: CGFloat = 50
//    private var stepCar: CGFloat = 25
//
//    private var processingGame: Bool = false
//
//    private let userDefaults = UserDefaults.standard
//    private let keyForScoreUserDefaults = "User_score_value"
//    private let keyForNameUserDefaults = "User_Text_Name"
//
//    private var score = 0 {
//        didSet {
//            self.scoreLabel.text = "SCORE: \(score)"
//            self.userDefaults.setValue(score, forKey: keyForScoreUserDefaults)
//            if let lastScore = userDefaults.value(forKey: keyForScoreUserDefaults) as? Int {
//                PlayerSinglton.shared.score = lastScore
//            }
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupRoadView()
//        setupScoreLabel()
//        setupPlayerNameLabel()
//        setupContainerForPauseAndMenuView()
//        setupCarImageView()
//        setupSecondRoadImageView()
//        setupRoadImageView()
//        setupTextGameOverLabel()
//        setupOncomingCar()
//        setupOncomingCarTwo()
//        setupOncomingCarThree()
//        setupContainerForButtonsView()
//        animateRoad(withDuration: withDurationRoad, delay: delayRoad)
//        animateOncomingCars(withDuration: withDurationOncomingCar, delay: delayOncomingCar, stepOrigin: stepOncomingCar)
//    }
//
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        processingGame = true
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        processingGame = false
//    }
//
//    private func setupContainerForPauseAndMenuView() {
//        view.addSubview(containerForPauseAndMenuView)
//    }
//
//    private func setupMenuView() {
//        menuView.layer.cornerRadius = 15
//        view.addSubview(menuView)
//    }
//
//    private func setupBlurEffectView() {
//        view.addSubview(blurEffectView)
//    }
//
//    private func setupContainerForButtonsView() {
//        view.addSubview(containerForButtonsView)
//    }
//
//
//
//    private func setupCarImageView() {
//        carImageView.image = UIImage(named: "yellow-car_icon")
//        carImageView.frame.size.height = heightCars
//        carImageView.frame.size.width = widthCars
//        carImageView.center.x = view.center.x
//        carImageView.frame.origin.y = view.frame.maxY - carImageView.frame.height - (carImageView.frame.height / 2)
//        carImageView.contentMode = .scaleToFill
//        carImageView.backgroundColor = .clear
//        view.addSubview(carImageView)
//    }
//
//    private func setupOncomingCar() {
//        oncomingCar.image = UIImage(named: CollorsCars.shared.arrayOncomingCars.randomElement() ?? "")
//        oncomingCar.frame.size.height = heightCars
//        oncomingCar.frame.size.width = widthCars
//        oncomingCar.frame.origin.y = -(heightCars)
//        oncomingCar.frame.origin.x = carImageView.frame.origin.x
//        oncomingCar.contentMode = .scaleToFill
//        oncomingCar.backgroundColor = .clear
//        view.addSubview(oncomingCar)
//    }
//
//    private func setupOncomingCarTwo() {
//        oncomingCarTwo.image = UIImage(named: CollorsCars.shared.arrayOncomingCars.randomElement() ?? "")
//        oncomingCarTwo.frame.size.height = heightCars
//        oncomingCarTwo.frame.size.width = widthCars
//        oncomingCarTwo.frame.origin.y = oncomingCar.frame.origin.y - mainContainerView.frame.height / 1.5
//        oncomingCarTwo.frame.origin.x = carImageView.frame.origin.x
//        oncomingCarTwo.contentMode = .scaleToFill
//        oncomingCarTwo.backgroundColor = .clear
//        view.addSubview(oncomingCarTwo)
//    }
//
//    private func setupOncomingCarThree() {
//        oncomingCarThree.image = UIImage(named: CollorsCars.shared.arrayOncomingCars.randomElement() ?? "")
//        oncomingCarThree.frame.size.height = heightCars
//        oncomingCarThree.frame.size.width = widthCars
//        oncomingCarThree.frame.origin.y = oncomingCarTwo.frame.origin.y - mainContainerView.frame.height / 1.5
//        oncomingCarThree.frame.origin.x = carImageView.frame.origin.x
//        oncomingCarThree.contentMode = .scaleToFill
//        oncomingCarThree.backgroundColor = .clear
//        view.addSubview(oncomingCarThree)
//    }
//
//    private func setupRoadView() {
//        roadView.frame.size.height = mainContainerView.frame.height
//        roadView.frame.size.width = mainContainerView.frame.width / 1.5
//        roadView.center.x = mainContainerView.center.x
//        roadView.backgroundColor = .clear
//        view.addSubview(roadView)
//    }
//
//    private func setupTextGameOverLabel() {
//        textGameOverLabel.frame.size = CGSize(width: mainContainerView.frame.width, height: 200)
//        textGameOverLabel.center.x = view.center.x
//        textGameOverLabel.frame.origin.y = 100
//        textGameOverLabel.text = "GAME OVER!"
//        textGameOverLabel.backgroundColor = .clear
//        textGameOverLabel.textColor = .red
//        textGameOverLabel.textAlignment = .center
//        textGameOverLabel.autoresizesSubviews = true
//        textGameOverLabel.font = UIFont(name: "Decaying Felt Pen", size: 30)
//        textGameOverLabel.layer.shadowColor = UIColor.black.cgColor
//        textGameOverLabel.layer.shadowRadius = 5
//        textGameOverLabel.layer.shadowOpacity = 1
//        textGameOverLabel.layer.shadowOffset = .zero
//        view.addSubview(textGameOverLabel)
//        guard let string = textGameOverLabel.text else {return}
//        let newMutableAttributedString = NSMutableAttributedString(string: string)
//        var index = 0
//        for _ in string {
//
//            newMutableAttributedString.addAttribute(.foregroundColor, value: Collors.shared.arrayCollors[index], range: _NSRange(location: index, length: 1))
//            index += 1
//        }
//        textGameOverLabel.attributedText = newMutableAttributedString
//        textGameOverLabel.isHidden = true
//    }
//
//    private func setupScoreLabel() {
//        scoreLabel.text = "SCORE: \(score)"
//        scoreLabel.font = UIFont(name: "Decaying Felt Pen", size: 12)
//        view.addSubview(scoreLabel)
//    }
//
//    private func setupPlayerNameLabel() {
//        playerNameLabel.text = PlayerSinglton.shared.name
//        playerNameLabel.font = UIFont(name: "Decaying Felt Pen", size: 12)
//        view.addSubview(playerNameLabel)
//    }
//
//    private func setupSecondRoadImageView() {
//        secondRoadImageView.image = UIImage(named: "road_icon")
//        secondRoadImageView.contentMode = .scaleToFill
//        secondRoadImageView.frame.size.height = mainContainerView.frame.height + 4
//        secondRoadImageView.frame.size.width = mainContainerView.frame.width
//        secondRoadImageView.frame.origin = CGPoint(x: mainContainerView.frame.origin.x, y: mainContainerView.frame.origin.y)
//        mainContainerView.addSubview(secondRoadImageView)
//    }
//
//    private func setupRoadImageView() {
//        roadImageView.image = UIImage(named: "road_icon")
//        roadImageView.contentMode = .scaleToFill
//        roadImageView.frame.size.height = mainContainerView.frame.height + 4
//        roadImageView.frame.size.width = mainContainerView.frame.width
//        roadImageView.frame.origin = CGPoint(x: mainContainerView.frame.origin.x, y: mainContainerView.frame.origin.y - roadImageView.frame.height)
//        mainContainerView.addSubview(roadImageView)
//    }
//
//    private func animateRoad(withDuration: Double, delay: Double) {
//        animateSecondRoadImageView(withDuration: withDuration, delay: delay) { }
//        animateRoadImageView(withDuration: withDuration, delay: delay) { }
//    }
//
//    private func animateRoadImageView(withDuration: Double, delay: Double, comletion: @escaping () -> ()) {
//        UIView.animate(withDuration: withDuration, delay: delay, options: [.curveLinear], animations: {
//            self.roadImageView.frame.origin.y += 10
//            if self.roadImageView.frame.origin.y >= self.mainContainerView.frame.maxY {
//                self.roadImageView.frame.origin.y = self.mainContainerView.frame.origin.y - self.roadImageView.frame.height
//            }
//        }, completion: { (_) in
//            if self.processingGame == true {
//                self.animateRoadImageView(withDuration: withDuration, delay: delay) { }
//                comletion()
//            }
//        })
//    }
//
//    private func animateSecondRoadImageView(withDuration: Double, delay: Double, comletion: @escaping () -> ()) {
//        UIView.animate(withDuration: withDuration, delay: delay, options: [.curveLinear], animations: {
//            self.secondRoadImageView.frame.origin.y += 10
//            if self.secondRoadImageView.frame.origin.y >= self.mainContainerView.frame.maxY {
//                self.secondRoadImageView.frame.origin.y = self.mainContainerView.frame.origin.y - self.roadImageView.frame.height
//            }
//        }, completion: { (_) in
//            if self.processingGame == true {
//                self.animateSecondRoadImageView(withDuration: withDuration, delay: delay) { }
//                comletion()
//            }
//        })
//    }
//
//    private func animateOncomingCars(withDuration: Double, delay: Double, stepOrigin: CGFloat ) {
//        animateOncomingCar(withDuration: withDuration, delay: delay, stepOrigin: stepOrigin) { }
//        animateOncomingCarTwo(withDuration: withDuration, delay: delay, stepOrigin: stepOrigin) { }
//        animateOncomingCarThree(withDuration: withDuration, delay: delay, stepOrigin: stepOrigin) { }
//    }
//
//    private func animateIfGameOver() {
//        processingGame = false
//        setupBlurEffectView()
//        setupTextGameOverLabel()
//        setupScoreLabel()
//        setupPlayerNameLabel()
//        textGameOverLabel.isHidden = false
//        UIView.animate(withDuration: 1) {
//            self.blurEffectView.alpha = 1
//        }
//        Timer.scheduledTimer(withTimeInterval: withTimeIntervalGameOver, repeats: false) { (timer) in
//            if let navigation = self.navigationController {
//            navigation.popToRootViewController(animated: false)
//            }
//        }
//    }
//
//    private func animateOncomingCar(withDuration: Double, delay: Double, stepOrigin: CGFloat, completion: @escaping () -> ()) {
//
//        UIView.animate(withDuration: withDuration, delay: delay, options: [.curveLinear], animations: {
//            self.oncomingCar.frame.origin.y += stepOrigin
//            if self.oncomingCar.frame.origin.y >= self.mainContainerView.frame.maxY {
//                self.score += 1
//                self.setupOncomingCar()
//            }
//            if self.oncomingCar.frame.intersects(self.carImageView.frame) {
//                self.animateIfGameOver()
//            }
//        }, completion: { (_) in
//            if self.processingGame == true {
//                self.animateOncomingCar(withDuration: delay, delay: delay, stepOrigin: stepOrigin) { }
//                completion()
//            }
//        })
//    }
//
//    private func animateOncomingCarTwo(withDuration: Double, delay: Double, stepOrigin: CGFloat, completion: @escaping () -> ()) {
//        UIView.animate(withDuration: withDuration, delay: delay, options: [.curveLinear], animations: {
//            self.oncomingCarTwo.frame.origin.y += stepOrigin
//            if self.oncomingCarTwo.frame.origin.y >= self.mainContainerView.frame.maxY {
//                self.score += 1
//                self.setupOncomingCarTwo()
//            }
//            if self.oncomingCarTwo.frame.intersects(self.carImageView.frame) {
//                self.animateIfGameOver()
//            }
//        }, completion: { (_) in
//            if self.processingGame == true {
//                self.animateOncomingCarTwo(withDuration: delay, delay: delay, stepOrigin: stepOrigin) { }
//                completion()
//            }
//        })
//    }
//
//    private func animateOncomingCarThree(withDuration: Double, delay: Double, stepOrigin: CGFloat, completion: @escaping () -> ()) {
//
//        UIView.animate(withDuration: withDuration, delay: delay, options: [.curveLinear], animations: {
//            self.oncomingCarThree.frame.origin.y += stepOrigin
//            if self.oncomingCarThree.frame.origin.y >= self.mainContainerView.frame.maxY {
//                self.score += 1
//                self.setupOncomingCarThree()
//            }
//            if self.oncomingCarThree.frame.intersects(self.carImageView.frame) {
//                self.animateIfGameOver()
//            }
//        }, completion: { (_) in
//            if self.processingGame == true {
//                self.animateOncomingCarThree(withDuration: delay, delay: delay, stepOrigin: stepOrigin) { }
//                completion()
//            }
//        })
//    }
//
//    private func animateCar(direction: DirectionMove, withDuration: Double, frame: CGFloat, completion: @escaping () -> ()) {
//        switch direction {
//        case.left:
//            if processingGame == true {
//            if carImageView.frame.minX > roadView.frame.minX {
//            UIView.animate(withDuration: withDuration, delay: 0, options: [.curveLinear], animations: {
//                self.carImageView.frame.origin.x -= frame
//            }, completion: { (_) in
//                completion()
//            })
//            } else {
//                self.animateIfGameOver()
//            }
//            }
//
//        case .right:
//            if processingGame == true {
//            if carImageView.frame.maxX < roadView.frame.maxX {
//            UIView.animate(withDuration: withDuration, delay: 0, options: [.curveLinear], animations: {
//                self.carImageView.frame.origin.x += frame
//            }, completion: { (_) in
//                completion()
//            })
//            } else {
//                self.animateIfGameOver()
//            }
//            }
//        }
//    }
//
//    @IBAction private func moveRightButtonPressed(_ sender: Any) {
//        animateCar(direction: DirectionMove.right, withDuration: withDurationCar, frame: stepCar) { }
//    }
//
//    @IBAction private func moveLeftButtonPressed(_ sender: Any) {
//        animateCar(direction: DirectionMove.left, withDuration: withDurationCar, frame: stepCar) { }
//    }
//
//    @IBAction func pauseButtonPressed(_ sender: UIButton) {
//        processingGame = !processingGame
//        sender.setImage(UIImage(systemName: "play"), for: .normal)
//        if processingGame == true {
//            sender.setImage(UIImage(systemName: "pause"), for: .normal)
//            animateOncomingCars(withDuration: withDurationOncomingCar, delay: delayOncomingCar, stepOrigin: stepOncomingCar)
//            animateRoad(withDuration: withDurationRoad, delay: delayRoad)
//
//        }
//    }
//
//    @IBAction func menuButtonPressed(_ sender: UIButton) {
//        processingGame = !processingGame
//        if processingGame == false || pauseButton.isHidden == false {
//            pauseButton.isHidden = true
//            processingGame = false
//            setupBlurEffectView()
//            setupMenuView()
//            setupContainerForPauseAndMenuView()
//            trailingMenuConstraint.constant = mainContainerView.center.x + menuView.frame.width / 2
//            UIView.animate(withDuration: 1) {
//                self.blurEffectView.alpha = 1
//                self.view.layoutIfNeeded()
//            }
//        } else {
//            trailingMenuConstraint.constant = 0
//            UIView.animate(withDuration: 1) {
//                self.blurEffectView.alpha = 0
//                self.view.layoutIfNeeded()
//            } completion: { (_) in
//                self.pauseButton.isHidden = false
//                self.pauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
//                self.animateRoad(withDuration: self.withDurationRoad, delay: self.delayRoad)
//                self.animateOncomingCars(withDuration: self.withDurationOncomingCar, delay: self.delayOncomingCar, stepOrigin: self.stepOncomingCar)
//            }
//        }
//    }
//
//    @IBAction func homeButtonPressed(_ sender: UIButton) {
//        if let navigation = self.navigationController {
//        navigation.popToRootViewController(animated: false)
//        }
//    }
//
//    @IBAction func exitButtonPressed(_ sender: UIButton) {
//        exit(0)
//    }
//
//
//}
