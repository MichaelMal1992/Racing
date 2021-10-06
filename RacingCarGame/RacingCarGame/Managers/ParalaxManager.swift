//
//  ParalaxManager.swift
//  RacingCarGame
//
//  Created by Admin on 15.08.21.
//

import UIKit
import CoreMotion

class ParalaxManager {

    static let shared = ParalaxManager()

    private let motionManager = CMMotionManager()

    func start(_ view: UIView, _ subView: UIView) {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 1 / 30
            motionManager.startAccelerometerUpdates(to: .main) { data, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let data = data {
                    UIView.animate(withDuration: 0.5) {
                        if data.acceleration.x > 0 {
                            subView.center.x = view.center.x + 20
                        }
                        if data.acceleration.x < 0 {
                            subView.center.x = view.center.x - 20
                        }
                        if data.acceleration.z < 0 {
                            subView.center.y = view.center.y - 20
                        }
                        if data.acceleration.z > 0 {
                            subView.center.y = view.center.y + 20
                        }
                    }
                }
            }
        }
    }

    func stop() {
        motionManager.stopGyroUpdates()
    }
}
