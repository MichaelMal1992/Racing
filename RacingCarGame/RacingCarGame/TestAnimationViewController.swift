//
//  TestAnimationViewController.swift
//  RacingCarGame
//
//  Created by Admin on 29.07.21.
//

import UIKit

class TestAnimationViewController: UIViewController {

    let imageView = UIImageView()
    let twoImageView = UIImageView()
    let carImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        twoImageView.image = UIImage(named: "road_icon")
        twoImageView.frame = view.frame
        twoImageView.frame.origin = CGPoint(x: 0, y: -view.frame.height)
        view.addSubview(twoImageView)

        imageView.image = UIImage(named: "road_icon")
        imageView.frame = view.frame
        imageView.frame.origin = CGPoint(x: 0, y: 0)
        view.addSubview(imageView)
        
        carImageView.image = UIImage(named: "01-car_icon")
        carImageView.frame.size = CGSize(width: 50, height: 100)
        carImageView.frame.origin = CGPoint(x: 100 , y: 500)
        view.addSubview(carImageView)
        
        
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animate()
    }
    

    func animate() {
        
        UIView.animate(withDuration: 5, delay: 0, options: [.curveLinear]) {
            self.imageView.frame.origin.y += self.view.frame.height
            self.twoImageView.frame.origin.y += self.view.frame.height
        } completion: { _ in
            if self.imageView.frame.origin.y == self.view.frame.height {
                self.imageView.frame.origin.y = -self.view.frame.height
            }
            if self.twoImageView.frame.origin.y == self.view.frame.height {
                self.twoImageView.frame.origin.y = -self.view.frame.height
            }

            self.animate()
        }
    }
    
    func animateCar() {
        
    }

}
